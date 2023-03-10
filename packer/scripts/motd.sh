#!/bin/sh

#rm -f /etc/update-motd.d/00-header \
#      /etc/update-motd.d/10-help-text \
#      /etc/update-motd.d/50-motd-news \
#      /etc/update-motd.d/95-hwe-eol


cat <<'EOH' > /etc/update-motd.d/00-header
#!/bin/sh

cat << EOF
                                       @@@@@@@@@@@@@#
                             ##@@%(***,,*************/(%@@@@&,
                       (@@@*,..,,,,,,,,,,,,********///((/////%@@@@@.
                  ,@@@&/....,,/(,.,..,*/#&&%#**/***/(##&&%#((//(**/@@@&
               ,@@*#(.....,**,.,,,/##,,......,,******////****/#&&(/(/**%@@.
             .@@*,(#/.,*,./**/*//(/*/((//////*******,,*******/(/**/%%/((*,%@@
             @&(.,/((((((@/&#(%%&#%#(%%#(#%&&&&&&#/****,,*****/*,*/(#((//(*,%@@#
          /@@#((@#%@@((#/#/((///*************//////&%((*****//**,*/*,/(&#(*(**&@@
        @@(*(#/#&*//******************************///#&##//****///*,*/*//&#*////@@
      .@#,,,%&%%*************************************//%%(/(**,***/((/*///(@//((#&@/
     .@/,.,(*%%,**************************************//@@*(/**,**/////(/*/(@#*#(&%@@
     @#*,.(,#@,,**********************,,,**************//%&,%**,******//*/(/#%%/((&%@&
    @&%*.*/*@#,,*********************,,,,***************///(%/*******//*//**((%((/%@%@(
    @@/(,(,#&.,**********************,,,*****************//%@&/*,**,,***///////#(/(&@%@,
   %@@*(,&/@,.,,,,,*,,**************,,,,,,,**************///#(@///*/*/**/**/(/*/((/(##@@
   @@@/%,@@/*%((%&(*,,,/#****%@(*****,,*(&#,,,***********/////&#****//**/*/(//(/*(/*(#@@
   &@@@&/@(*%&&@%(/((,,*/@(/,**/%&@@@@&%%%#/*(*************///%%***##(((&&%%%#(((/(**#&@@
       @@%&,,*,*/(((&,,**((%%###((****,,,,,,**//***,********//%@(/#%%&%(//%&(**@#((/,/%@@
         @@&/(#&&@&%@,**//////(((%@@@@@@&#(/*///////*********/%/(#&@%(//&@#(((&*@(//,*&%@&
          *&,%/(#@@@(***///////((#@@%&@&%%(//**/(/////*********//(##///@#(((#(#*@((/*/&#@@(
          @#,,,***/&****////**,*/(((/*************//*************/**//&@#(@%(#/#@/(/*(&%/@@
         .@***((#%%****//////**,**///////***********///////***********%@(((%(/%@@(/*/%#@(/&@
         @&,****/&//*,*///////*,****************///////////**********/&(((@**&&@%&//*%#%@%*#@@
         @@,///%&//***/////////****,,,,,,,****/////////////**********//((**#@%#(@&%*/*&(%@@&(#@%
         .@/*/&#((*,,*///////***(/*,,******///////////////****************(@@#((/(#%**/&/%@@@@@%@&
          @%*/#@#(((((((((((((###(/%*******//////////////*************(%&@@%@%#/(/(%&/,/#/#@@& @@@@
          ,@#*////##%&####((#((((///#@******///////////****************/((((@@%(%((*%%/,/#*#%@@  (*
           #@/****(,/***/,,***,///////(/********************************/((&@&@&&#%/,#(*,(#/%(@@.
            @@****#(#/(&&&(/#(%(/*,*****/******************************/((%&&&#&&@@@*(/*,*&/%#(@@
             @&***##&@@@&%&@@@@@@@@@@@@@@%***************************/((%@&@##%&&@@@(#*/,,&/&@#%@&
             .@%,**/(&@@&&%%#((((((///*****************************/((%@&@%##&@&&@@@(%,*.(&(%@&#@&
              %@/***(&#(//////((#%#/*****************************/((&@@&##%@&%%&@@@&(/,.*@(@@&&@@(
               @@*****/(((((((////****************************/(((@@&##%&@%%%%&@&&@%&,.*@@&@@&&&@@#
                @@#*,.***************************/((******///((#@@##%&&%%#%%&@&%&@@@,,@@&%@@&%%%%&@/
                 @@*.,**////////*////****//////#&/******//(((&@##%@&%%###%&@@#%&@@&*%@&%@&&%##%%%@@/
                 %@&//////////////////////(((@%******///((#@&#&@%%#####%&&@#%&@&&@@&&&@&%####%&@@@%
             /@@@&##@@@%((((((((((((((((#@@%/*****//((((%@&@%########%&@@%&@@@&&&&&&%%####%&&@&&@@#
           #@@@###%&@@(//(((#%%%%%%###(/******/((((#@@@@%#########%&&@&%@@&&&&&&&%#####%&@@&%%&@@&
          ,@@&####%@&@@%*****/////////////(((#&@@@&%###########%%&@@&@@&&&&@@&%####%&@@&%%%&@@%##%@@
        .@@@%@###%%&@&&&@@@@@@@@@@@@@@@@@&&%################%%&@@@@&&&@@&%%####%&&@&%&@@&%######((##
EOF

echo "                       ______        __         __         ";
echo "                      / ____/____ _ / /_ _____ / /__ ____ _";
echo "                     / /_   / __ \`// __// ___// //_// __ \`/";
echo "                    / __/  / /_/ // /_ (__  )/ ,<  / /_/ / ";
echo "                   /_/     \__,_/ \__//____//_/|_| \__,_/  ";
echo " ";
EOH

cat <<'EOH' > /etc/update-motd.d/10-system-info
#!/bin/sh

UPTIME_DAYS=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 / 86400)
UPTIME_HOURS=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 % 86400 / 3600)
UPTIME_MINUTES=$(expr `cat /proc/uptime | cut -d '.' -f1` % 31556926 % 86400 % 3600 / 60)
DISTRO=$(lsb_release -s -d)
KERNEL=$(uname -r)

CPU_LOAD_AVG=$(cat /proc/loadavg | awk '{print $1 ", " $2 ", " $3}')
AVAILABLE_MEMORY=$(free -m | head -n 2 | tail -n 1 | awk {'print $4'})
AVAILABLE_DISK=$(df -h / | awk '{ a = $4 } END { print a }')

cat << EOF
%                                                                                                   %
%++++++++++++++++++++++++++++++++++++++++++ SERVER INFO ++++++++++++++++++++++++++++++++++++++++++++%
%                                                                                                   %
           Name: $HOSTNAME
           Uptime: $UPTIME_DAYS days, $UPTIME_HOURS hours, $UPTIME_MINUTES minutes
           Distro: $DISTRO with $KERNEL
EOF
EOH

cat <<'EOH' > /etc/update-motd.d/99-footer
#!/bin/sh

echo "%                                                                                                   %"
echo "%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%"
EOH

chown root: /etc/update-motd.d/00-header
chown root: /etc/update-motd.d/10-system-info
chown root: /etc/update-motd.d/99-footer

chmod 755 /etc/update-motd.d/00-header
chmod 755 /etc/update-motd.d/10-system-info
chmod 755 /etc/update-motd.d/99-footer


cat <<'EOF' > /etc/ssh/banner
banner
EOF

