Reset_clr='\033[0m'
Err=1
case $L_bckgrnd_clr in
        1 )    L_bckgrnd_clr='\033[47m' ; L_bckgrnd_txt='white' ;;   # white
        2 )    L_bckgrnd_clr='\033[41m' ; L_bckgrnd_txt='red' ;;   # red   
        3 )    L_bckgrnd_clr='\033[42m' ; L_bckgrnd_txt='green' ;;   # green
        4 )    L_bckgrnd_clr='\033[44m' ; L_bckgrnd_txt='blue' ;;   # blue
        5 )    L_bckgrnd_clr='\033[45m' ; L_bckgrnd_txt='purple' ;;   # purple
        6 )    L_bckgrnd_clr='\033[40m' ; L_bckgrnd_txt='black' ;;   # black
        * )    Err=0;;
esac    
case $L_txt_clr in
        1 )    L_txt_clr='\033[0;37m' ; L_txt_txt='white' ;;   # white
        2 )    L_txt_clr='\033[0;31m' ; L_txt_txt='red' ;;   # red   
        3 )    L_txt_clr='\033[0;32m' ; L_txt_txt='green' ;;   # green
        4 )    L_txt_clr='\033[0;34m' ; L_txt_txt='blue' ;;   # blue
        5 )    L_txt_clr='\033[0;35m' ; L_txt_txt='purple' ;;   # purple
        6 )    L_txt_clr='\033[0;30m' ; L_txt_txt='black' ;;   # black
        * )    Err=0;;
esac
case $R_bckgrnd_clr in
        1 )    R_bckgrnd_clr='\033[47m' ; R_bckgrnd_txt='white' ;;   # white
        2 )    R_bckgrnd_clr='\033[41m' ; R_bckgrnd_txt='red' ;;   # red   
        3 )    R_bckgrnd_clr='\033[42m' ; R_bckgrnd_txt='green' ;;   # green
        4 )    R_bckgrnd_clr='\033[44m' ; R_bckgrnd_txt='blue' ;;   # blue
        5 )    R_bckgrnd_clr='\033[45m' ; R_bckgrnd_txt='purple' ;;   # purple
        6 )    R_bckgrnd_clr='\033[40m' ; R_bckgrnd_txt='black' ;;   # black
        * )    Err=0;;
esac
case $R_txt_clr in
        1 )    R_txt_clr='\033[0;37m' ; R_txt_txt='white' ;;   # white
        2 )    R_txt_clr='\033[0;31m' ; R_txt_txt='red'  ;;   # red   
        3 )    R_txt_clr='\033[0;32m' ; R_txt_txt='green'  ;;   # green
        4 )    R_txt_clr='\033[0;34m' ; R_txt_txt='blue'  ;;   # blue
        5 )    R_txt_clr='\033[0;35m' ; R_txt_txt='purple'  ;;   # purple
        6 )    R_txt_clr='\033[0;30m' ; R_txt_txt='black'  ;;   # black
        * )    Err=0;;
esac
