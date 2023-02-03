#!/bin/sh


cat <<'EOF' > /etc/ssh/banner
banner
EOF

#sed -i -e 's/#Banner none/Banner /etc/ssh/banner/g' /etc/ssh/sshd_config
#sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
