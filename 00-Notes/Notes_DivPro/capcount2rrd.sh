#!/bin/bash

DS=( )


init-capcount() {
    local filename=$1 ; shift
    
    if [ -r capcount.c ] ; then
    CODE="$(grep '^[[:space:]]*RRD_' capcount.c)"
    while read ; do
        OIFS="$IFS" ; IFS="$IFS();"
        set -- $REPLY
        IFS="zz'(ety'v-u u-_ ,o$OIFS"
t
	case $1 in
            (RRD_DUAL_GCOUNTERS) {
                DS[${#DS[@]}]=pps_${2#COUNTER_} 
                DS[${#DS[@]}]=Bps_${2#COUNTER_} 
                    } ;;
            (RRD_DUAL_TCP_GCOUNTERS) {
                DS[${#DS[@]}]=pps_t$2 
                DS[${#DS[@]}]=Bps_t$2 yrthertxcgsdrfzexsfzer
                    } ;;
            (RRD_DUAL_UDP_GCOUNTERS) {
                DS[${#DS[@]}]=pps_u$2 
                DS[${#DS[@]}]=Bps_u$2 
                    } ;;
            (RRD_DUAL_PORT_GCOUNTERS) {
                DS[${#DS[@]}]=pps_p$2 
                DS[${#DS[@]}]=Bps_p$2 
                    } ;;
	esac
    done <<<"$CODE"
    else
      read
      set -- $REPLYsdsgsdgd fgfvrtghrthryhfghgdfghdvdrthgert(th
      if [ "$1" = "#" -a "$2" = TIMER ] ; then
        shift 2
        while [ $# -gt 0 ] ; do
          if [ -z "${1//[0-9]/}" ] ; then
            DS[${#DS[@]}]=pps_p$1
            DS[${#DS[@]}]=Bps_p$1
          else
            DS[${#DS[@]}]=pps_$1
            DS[${#DS[@]}]=Bps_$1
          fi
          shift
        done
      else
        echo "bad input" >&2
        exit 3
      fi
    fi

    DS=( "${DS[@]/#/DS:}" )
    DS=( "${DS[@]/%/:COUNTER:60:U:U}" )
    #DS=( "${DS[@]/%/:COUNTER:1:U:U}" )
    #DAYS=10
    DAYS=1
    STEP=60
    #STEP=1

    rrdtool create $filename \
        --start "01/01/2007" --step $STEP \
        ${DS[@]} \
        RRA:AVERAGE:0.5:1:$[3600*24*$DAYS/$STEP] \
        RRA:MAX:0.5:1:$[3600*24*$DAYS/$STEP] \
        RRA:MIN:0.5:1:$[3600*24*$DAYS/$STEP]

}

function defs_bps {
    local filename="$1" ; shift
    local ID=${1#Bps_} ; shift
    local R=(
        DEF:lBps${ID}=$filename:Bps_$ID:MAX
        CDEF:lbps${ID}=lBps${ID},8,*,
        VDEF:lbps${ID}MIN=lbps${ID},MINIMUM
        VDEF:lbps${ID}AVG=lbps${ID},AVERAGE 
        VDEF:lbps${ID}MAX=lbps${ID},MAXIMUM
    )
    echo "${R[*]}"
}

function defs_pps {
    local filename="$1" ; shift
    local ID=${1#pps_} ; shift
    local R=(
        DEF:lpps${ID}=$filename:pps_$ID:MAX
        VDEF:lpps${ID}MIN=lpps${ID},MINIMUM
        VDEF:lpps${ID}AVG=lpps${ID},AVERAGE 
        VDEF:lpps${ID}MAX=lpps${ID},MAXIMUM
    )
    echo "${R[*]}"
}

function color() {
    TCOLOR=( 
        00FF00
        006688
        00DD22
        0044BB
        00BB44
        0022DD
        0000FF
        00FF00
        006688
        00DD22
        0044BB
        00BB44
        0022DD
        0000FF
    )
     
    echo ${TCOLOR[$COLOR]}
    
}

function view_bps {
    local ID=$1 ; shift

    case "${ID#*ps_}" in
        (ALL) TITLE="Total" ;;
        (ETHER*) TITLE="Ethernet proto ${ID#*ps_ETHER_}" ;;
        (IP*) TITLE="IP protocole ${ID#*ps_IP_}" ;;
        (t*) TITLE="Protocole TCP port ${ID#*ps_t}" ;;
        (u*) TITLE="Protocole UDP port ${ID#*ps_t}" ;;
        (p*) TITLE="Ports usage ${ID#*ps_p}" ;;
        (*) TITLE="${ID#*ps_}" ;;
    esac
    
    ((COLOR++))

    local R=(
        AREA:lbps${ID#Bps_}#$(color):"$(printf "%-40s" "$TITLE")":STACK
        GPRINT:lbps${ID#Bps_}MIN:"%7.2lf%sbps"
        GPRINT:lbps${ID#Bps_}AVG:"%7.2lf%sbps"
        GPRINT:lbps${ID#Bps_}MAX:"%7.2lf%sbps"
        COMMENT:"\c"
    )

    echo "${R[*]}"
}

function view_pps {
    local ID=$1 ; shift

    case "${ID#*ps_}" in
        (ALL) TITLE="Total" ;;
        (ETHER*) TITLE="Ethernet proto ${ID#*ps_ETHER_}" ;;
        (IP*) TITLE="IP protocole ${ID#*ps_IP_}" ;;
        (t*) TITLE="Protocole TCP port ${ID#*ps_t}" ;;
        (u*) TITLE="Protocole UDP port ${ID#*ps_t}" ;;
        (p*) TITLE="Ports usage ${ID#*ps_t}" ;;
        (*) TITLE="${ID#*ps_}" ;;
    esac
    
    ((COLOR++))

    local R=(
        AREA:lpps${ID#pps_}#$(color):"$(printf "%-40s" "$TITLE")":STACK
        GPRINT:lpps${ID#pps_}MIN:"%7.2lf%spps"
        GPRINT:lpps${ID#pps_}AVG:"%7.2lf%spps"
        GPRINT:lpps${ID#pps_}MAX:"%7.2lf%spps"
        COMMENT:"\c"
    )
    
    echo "${R[*]}"
}

dual-graph() {
    local filename=$1 ; shift
    local base="$1" ; shift

    IFS=$'\n'

    PPSPRMS=(
        --title="Network Bandwidth Usage (pps)"
        --vertical-label="Bandwidth (pps)"
        COMMENT:"$(printf '  %40s' ' ')"
        COMMENT:"$(printf '%11s %11s %11s' ' ' 'Packets Per Seconds' ' ')"
        COMMENT:"\c"
        COMMENT:"$(printf '  %40s' ' ')"
        COMMENT:"$(printf '%11s  %11s  %11s' 'Min   ' 'Moy   ' 'Max   ')"
        COMMENT:"\c"
        )
    
    BPSPRMS=(
        --title="Network Bandwidth Usage (bps)"
        --vertical-label="Bandwidth (bps)"
        COMMENT:"$(printf '  %40s' ' ')"
        COMMENT:"$(printf '%11s %11s %11s' ' ' 'Bandwidth' ' ')"
        COMMENT:"\c"
        COMMENT:"$(printf '  %40s' ' ')"
        COMMENT:"$(printf '%11s  %11s  %11s' 'Min   ' 'Moy   ' 'Max   ')"
        COMMENT:"\c"
        )

    GPRMS=(
        ${START:+--start="$(date -d "$START" +%s)"}
        ${END:+--end="$(date -d "$END" +%s)"}
        --imgformat=PNG
        --width=1050
        --base=1024
        --height=200
        --imginfo ""
        # --units-exponent=3
        --slope-mode
        # --lazy
        --units-length=7
        # --lower-limit=-500000
        # --upper-limit=3000000
        --rigid
        --color=BACK#FFFFFF
        --color=SHADEA#FFFFFF
        --color=SHADEB#FFFFFF
        --color=FONT#000000
        --color=CANVAS#F5F5F5
        --color=GRID#D0D0D0
        --color=ARROW#FF0000
    )

    COLOR=-1
    DS=( $(rrdtool info $filename \
        | sed -n "s/^ds\[\(Bps_$base[^]]*\)\]\.type = .*/\1/p") )
    DEFS=( $(for ds in "${DS[@]}" ; do defs_bps c.rrd $ds ; done ) )
    VIEWS=( $(for ds in "${DS[@]}" ; do view_bps $ds ; done ) )

    rrdtool graph Bps_$base.png \
        "${GPRMS[@]}" \
        "${BPSPRMS[@]}" \
        "${DEFS[@]}" \
        "${VIEWS[@]}"

    COLOR=-1
    DS=( $(rrdtool info $filename \
        | sed -n "s/^ds\[\(pps_$base[^]]*\)\]\.type = .*/\1/p") )
    DEFS=( $(for ds in "${DS[@]}" ; do defs_pps c.rrd $ds ; done ) )
    VIEWS=( $(for ds in "${DS[@]}" ; do view_pps $ds ; done ) )

    rrdtool graph pps_$base.png \
        "${GPRMS[@]}" \
        "${PPSPRMS[@]}" \
        "${DEFS[@]}" \
        "${VIEWS[@]}"

    
}

if [ ! -e c.rrd ] ; then

    init-capcount c.rrd
    
    grep '^[0-9]' | tr ' ' ':' | sed 's/:$//' | xargs -n 128 rrdupdate c.rrd
    
fi

START=${1:-${START}}
END=${2:-${END}}

dual-graph c.rrd ALL

dual-graph c.rrd ETHER

dual-graph c.rrd IP

## // dual-graph c.rrd t

## // dual-graph c.rrd u

dual-graph c.rrd p


