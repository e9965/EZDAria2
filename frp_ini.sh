Vfrp="0.16.1" && wget -qO - https://github.com/fatedier/frp/releases/download/v${Vfrp}/frp_${Vfrp}_linux_amd64.tar.gz | tar -xzC /datasets && mv /datasets/frp_${Vfrp}_linux_amd64 /datasets/frp
cat > /datasets/frp/frpc.ini << EOF
[common]
server_addr = freenat.bid
server_port = 7000
privilege_token = frp888

[${RANDOM}]
type = tcp
local_ip = 127.0.0.1
local_port = 6800
remote_port = ${1}
#修改remote_port | 端口在：4000-50000 之间 | 建议改成难记的端口以免占用

[${RANDOM}]
type = tcp
local_ip = 127.0.0.1
local_port = 51413
remote_port = 51413

[${RANDOM}]
type = tcp
local_ip = 127.0.0.1
local_port = 10086
remote_port = ${2}
#与Aria2不同
EOF
ln -s /datasets/frp/frpc /bin/frpc
frpc -c /datasets/frp/frpc.ini
