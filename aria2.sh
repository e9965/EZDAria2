sh_ver="2.7.3"
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/sbin:/bin
aria2_passwd=${1} && [[ -z ${aria2_passwd} ]] && aria2_passwd=$(openssl rand -hex 5)
aria2_conf_dir="/root/.aria2c" && mkdir -p ${aria2_conf_dir}
download_path="/datasets/temp/unzip"
aria2_conf="${aria2_conf_dir}/aria2.conf"
aria2_log="${aria2_conf_dir}/aria2.log" && touch ${aria2_log}
aria2c="/usr/local/bin/aria2c"
Crontab_file="/usr/bin/crontab"
port=10086
method="chacha20-ietf"
protocol="auth_sha1_v4"
obfs="http_simple"
FILENAME="ShadowsocksR-v3.2.2"
URL="https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz"
BASE=`pwd`
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
Info="[${Green_font_prefix}信息${Font_color_suffix}]"
Error="[${Red_font_prefix}错误${Font_color_suffix}]"
Tip="[${Green_font_prefix}注意${Font_color_suffix}]"
LINE="======================================================="
cat > /datasets/rclone.conf <<EOF
[Onedrive]
type = onedrive
client_id = e6adedec-2a30-40e0-9736-493192820a4a
client_secret = F.pUadXlmtzp-2M~b-8Ifogy5cLa-5vp~N
region = global
token = {"access_token":"eyJ0eXAiOiJKV1QiLCJub25jZSI6IjJaWGtmbldQWl95U1QyUGx3Zi05bWJTTFhZdVhQQzFuNXJ2VHF1TmJRZ0kiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDAiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9lZjYzN2EzNS1kY2E0LTRkZTMtOTE4OC0zODAzMGQ3NWZjMzIvIiwiaWF0IjoxNjE4MDY4NjIyLCJuYmYiOjE2MTgwNjg2MjIsImV4cCI6MTYxODA3MjUyMiwiYWNjdCI6MCwiYWNyIjoiMSIsImFjcnMiOlsidXJuOnVzZXI6cmVnaXN0ZXJzZWN1cml0eWluZm8iLCJ1cm46bWljcm9zb2Z0OnJlcTEiLCJ1cm46bWljcm9zb2Z0OnJlcTIiLCJ1cm46bWljcm9zb2Z0OnJlcTMiLCJjMSIsImMyIiwiYzMiLCJjNCIsImM1IiwiYzYiLCJjNyIsImM4IiwiYzkiLCJjMTAiLCJjMTEiLCJjMTIiLCJjMTMiLCJjMTQiLCJjMTUiLCJjMTYiLCJjMTciLCJjMTgiLCJjMTkiLCJjMjAiLCJjMjEiLCJjMjIiLCJjMjMiLCJjMjQiLCJjMjUiXSwiYWlvIjoiRTJaZ1lCQVJWSXljVzhWeTEzTG13WFNtbmNYWlhCWGZWZDl3Ukh2dStDOHR1dkxCMnFzQSIsImFtciI6WyJwd2QiXSwiYXBwX2Rpc3BsYXluYW1lIjoiU2hlbGxEcml2ZSIsImFwcGlkIjoiZTZhZGVkZWMtMmEzMC00MGUwLTk3MzYtNDkzMTkyODIwYTRhIiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiJXb25nIiwiZ2l2ZW5fbmFtZSI6Ikt3b2sgWWluIiwiaWR0eXAiOiJ1c2VyIiwiaXBhZGRyIjoiMjAzLjIxOC4xODIuMTA2IiwibmFtZSI6Ikt3b2sgWWluIFdvbmciLCJvaWQiOiJiZjcyNmY0Yy1iZTY4LTRlZWItYmE3Zi1jOThkMDc0Mzc5NmIiLCJwbGF0ZiI6IjMiLCJwdWlkIjoiMTAwMzIwMDBCNzhEQTYzMiIsInJoIjoiMC5BVW9BTlhwajc2VGM0MDJSaURnRERYWDhNdXp0cmVZd0t1QkFselpKTVpLQ0NrcEtBTUUuIiwic2NwIjoiRmlsZXMuUmVhZCBGaWxlcy5SZWFkLkFsbCBGaWxlcy5SZWFkV3JpdGUgRmlsZXMuUmVhZFdyaXRlLkFsbCBTaXRlcy5SZWFkLkFsbCBVc2VyLlJlYWQgcHJvZmlsZSBvcGVuaWQgZW1haWwiLCJzaWduaW5fc3RhdGUiOlsia21zaSJdLCJzdWIiOiJNNDc2MTZYdnZXWm1JMWswZmlqemR4TTlmeG1IY1h6M1N0eFBJZkhoNWtzIiwidGVuYW50X3JlZ2lvbl9zY29wZSI6IkFTIiwidGlkIjoiZWY2MzdhMzUtZGNhNC00ZGUzLTkxODgtMzgwMzBkNzVmYzMyIiwidW5pcXVlX25hbWUiOiJLZW5ueWRyaXZlQGxpdmVzdHVkeS5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJLZW5ueWRyaXZlQGxpdmVzdHVkeS5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJuQUh2ckwzNjZVV0U2am45cjZjVEFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyI2MmU5MDM5NC02OWY1LTQyMzctOTE5MC0wMTIxNzcxNDVlMTAiLCJiNzlmYmY0ZC0zZWY5LTQ2ODktODE0My03NmIxOTRlODU1MDkiXSwieG1zX3N0Ijp7InN1YiI6ImRLRk5uOWM4UC12bU1DczlYNzRaZWhFNzNnaFBUM1RIOXYyRGFON2Y4SzgifSwieG1zX3RjZHQiOjE1ODc4MTU1MzN9.fFaqcqHeqdPhviF_nUZGr7FGAK57am3Vwnbv5Xzn2hbpqR1VBhprBbesaRV3M-WK4FKDjllRCEFVQ5f3JBLB-suTHTMqlUfg4S55ZUo_JesheWjt8JahYPjXSDq-gqCw1Zq-zxiiArBl5N3CLHSCGXP2pLIBoiDs9RySWBINXelsiA1XJCQJE_pzNeP6qFU_Wgu0yarbXXSe_-WaCP8vrURnEtp5V2_7RQ_pZY4A8C8JR1IzJfFM-qa4qDsvwOz6HEPSierGaLDuFb3fT7Hel_zst-LemS3wXjEB8lwU05hH9I1APff7Y1Pzt-Nf4AG0xnH0TlCzi0ZC-Hz6iHKcAQ","token_type":"Bearer","refresh_token":"0.AUoANXpj76Tc402RiDgDDXX8MuztreYwKuBAlzZJMZKCCkpKAME.AgABAAAAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P-8DpAR4Zurdilh7O2SirAdf8tHxx9k1j1ofbjYObItGiBBHM-3uwoI9j5Utf-aGqrKoac3DH7p5vSA3zRllcIbn1--vhGk4ytKNfxgoudBFrzPGD7BQiCefMdQ0wc7Bwf1Nk_c55fb5bC7KzGNbcNzJGWrT93KCyNsR2ZFvBRnjOsIczyNfDyqdwZepiJlQPyqaKybxVtNatIZqsjuNXp1_oWB_465FSaH97KxTmtKJOEmh5TA8zL1hSgSdHMoFpIqdjMWj2Oh4CytBI7SfgjrbcRdFGq4DAyRbDSE3OYjXDtdLozliY-4Kkp8lyPZB7YdlZgUuv1wdyVZ1pKhLteHqqii_ZNBbmjsKjw2wG-JJlkKXon4WedzK4hcd4OYgOzqthbcUx28HS_yRvnjez9onPGI8uV5lKulcZV8L9yJ9k8WZRLFEl8q5BRPEj4Kq9dfs5M2nGvkEZeyqu4ZqzS5vR9gpsAotrokxmZ91g9MFDl1oo1zwQFf9xrChrP9E6HOnk6f26IuSR70P-zQdhEWQ0-1Il7kcWpn_qQA7iOh2YfWcLPPLO6ZQGX4A7Vwnu2epUPS98f4jueBhZJeps9efyhSmYCAKASvn7b3OE8N2qb3q6KTsfGVHc4b-d7mXJeuVuuXFC2aAlTC1CGLGsprOvpqiLeGkvnamK_-V-wU7Tq5byZY-wGAgz3WRx_TmrhC4NEF9W10uDzmrryZLZ9CplF9JzGSvL_BHvcTvQP5-pS-KuwNOL3UOnyFBrIzH9UaCMWoVgRe6rQxDWzkO-MYwSXMnj-lWrw6HoWxNixr2yYdTHXZ9y7Im7VvEdEc-tDzijoq8MuNPR1OF3mK0NRpe-uF-ZGWaCjKJCi32gTB4YBcmFSl2SH1nasm-bB0z9L9HM8qGdz1o7ch-DXb678TZb-_XKEXDjhuwR9wKzCkwzz99YcgftzXDGrjIcla-L8W3ss","expiry":"2021-04-11T00:35:21.7784769+08:00"}
drive_id = b!Eqi24yxqskerRNr1u_lOk00lazGaLd5PhaR2PCLAGBnPUNHHJwlBTZYrzougHOta
drive_type = business
[Google]
type = drive
client_id = 959968594915-nhjkq2o036uhpn371fsecdu5g5qe1man.apps.googleusercontent.com
client_secret = 5PSKfHPsuDatfNMkb-rmxHdz
scope = drive
root_folder_id = 1a024AbVvZ19ua-1cqiQ-e5b1xpYqLP2H
token = {"access_token":"ya29.a0AfH6SMAKQECT3hk8-pyTOOBDE69x1R4IJyj9m94mf06hBB2_GID1k7NdRFUUDd8GP-8ENpuQaNlYw-1uFTnnR1fpZo7bbli7xbOQWqct2i3xouI5ZcQblrEqko2fYNycaCzJf-xCmQZLcqFVBp6OVfLvnu-g","token_type":"Bearer","refresh_token":"1//05fLupGIHfwY9CgYIARAAGAUSNwF-L9Ir_YF4v5dzPuKWJPO6P0TAqIdEqkD47bCZtz43qLHaEZxpR6kXuozNZtICORwwEIyCKPQ","expiry":"2021-04-07T11:52:43.953845811Z"}
EOF
INSTALL_SSR(){
    if [ ! -d /usr/local/shadowsocks ]; then
        if ! wget --no-check-certificate -O ${FILENAME}.tar.gz ${URL}; then
            echo "搭建SSR出错" && exit 2
        fi
        tar -zxf ${FILENAME}.tar.gz
        mv shadowsocksr-3.2.2/shadowsocks /usr/local
        if [ ! -f /usr/local/shadowsocks/server.py ]; then
            cd ${BASE} && rm -rf shadowsocksr-3.2.2 ${FILENAME}.tar.gz
            echo "搭建SSR出错" && exit 2
        fi
    fi
    cat > /etc/shadowsocksR.json<<-EOF
{
    "server":"0.0.0.0",
    "server_ipv6":"[::]",
    "server_port":${port},
    "local_port":1081,
    "password":"${aria2_passwd}",
    "timeout":600,
    "method":"${method}",
    "protocol":"${protocol}",
    "protocol_param":"",
    "obfs":"${obfs}",
    "obfs_param":"",
    "redirect":"",
    "dns_ipv6":false,
    "fast_open":false,
    "workers":1
}
EOF
    /usr/local/shadowsocks/server.py -c /etc/shadowsocksR.json -d start
    sleep 3
    res=`netstat -nltp | grep ${port} | grep python`
    if [ "${res}" = "" ]; then
        echo "搭建SSR出错" && exit 2
    fi
    cd ${BASE} && rm -rf shadowsocksr-3.2.2 ${FILENAME}.tar.gz
}
APT_INSTALL(){
	IFS=" "
	touch /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" > /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb-src http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list.d/aliyun.list
	sudo echo "deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list.d/aliyun.list
	sudo apt-get update -y
	apt-get install --ignore-missing -y p7zip-full p7zip-rar file rsync dos2unix cron wget curl ca-certificates findutils jq tar gzip dpkg telnet net-tools libsodium23 openssl unzip net-tools dnsutils
    apt autoremove -y
	res=`which python`
	if [ "$?" != "0" ]; then
		ln -s /usr/bin/python3 /usr/bin/python
	fi
	if [[ ! -s /etc/ssl/certs/ca-certificates.crt ]]; then
        wget -qO- git.io/ca-certificates.sh | bash
    fi
    curl https://rclone.org/install.sh | sudo bash
	IFS=$(echo -en "\n\b")
}
check_pid() {
    PID=$(ps -ef | grep "aria2c" | grep -v grep | grep -v "aria2.sh" | grep -v "init.d" | grep -v "service" | awk '{print $2}')
}
check_new_ver() {
    aria2_new_ver=$(
        {
            wget -t2 -T3 -qO- "https://api.github.com/repos/P3TERX/aria2-builder/releases/latest" ||
                wget -t2 -T3 -qO- "https://gh-api.p3terx.com/repos/P3TERX/aria2-builder/releases/latest"
        } | grep -o '"tag_name": ".*"' | head -n 1 | cut -d'"' -f4
    )
    if [[ -z ${aria2_new_ver} ]]; then
        echo -e "${Error} Aria2 最新版本获取失败，请手动获取最新版本号[ https://github.com/P3TERX/aria2-builder/releases ]"
        read -e -p "请输入版本号:" aria2_new_ver
        [[ -z "${aria2_new_ver}" ]] && echo "取消..." && exit 1
    fi
}
Download_aria2() {
    while [[ $(which aria2c) ]]; do
        echo -e "${Info} 删除旧版 Aria2 二进制文件..."
        rm -vf $(which aria2c)
    done
    DOWNLOAD_URL="https://github.com/P3TERX/aria2-builder/releases/download/${aria2_new_ver}/aria2-${aria2_new_ver%_*}-static-linux-amd64.tar.gz"
    {
        wget -t2 -T3 -O- "${DOWNLOAD_URL}" ||
            wget -t2 -T3 -O- "https://gh-acc.p3terx.com/${DOWNLOAD_URL}"
    } | tar -zx
    [[ ! -s "aria2c" ]] && echo -e "${Error} Aria2 下载失败 !" && exit 1
    [[ ${update_dl} = "update" ]] && rm -f "${aria2c}"
    mv -f aria2c "${aria2c}"
    [[ ! -e ${aria2c} ]] && echo -e "${Error} Aria2 主程序安装失败！" && exit 1
    chmod +x ${aria2c}
    echo -e "${Info} Aria2 主程序安装完成！"
}
Download_aria2_conf() {
    PROFILE_URL1="https://p3terx.github.io/aria2.conf"
    PROFILE_URL2="https://aria2c.now.sh"
    PROFILE_URL3="https://cdn.jsdelivr.net/gh/P3TERX/aria2.conf@master"
    PROFILE_LIST="
aria2.conf
clean.sh
core
script.conf
rclone.env
upload.sh
delete.sh
dht.dat
dht6.dat
move.sh
LICENSE
"
    mkdir -p "${aria2_conf_dir}" && cd "${aria2_conf_dir}"
    for PROFILE in ${PROFILE_LIST}; do
        [[ ! -f ${PROFILE} ]] && rm -rf ${PROFILE}
        wget -N -t2 -T3 ${PROFILE_URL1}/${PROFILE} ||
            wget -N -t2 -T3 ${PROFILE_URL2}/${PROFILE} ||
            wget -N -t2 -T3 ${PROFILE_URL3}/${PROFILE}
        [[ ! -s ${PROFILE} ]] && {
            echo -e "${Error} '${PROFILE}' 下载失败！清理残留文件..."
            rm -vrf "${aria2_conf_dir}"
            exit 1
        }
    done
    sed -i "s@^\(dir=\).*@\1${download_path}@" ${aria2_conf}
    sed -i "s@/root/.aria2/@${aria2_conf_dir}/@" ${aria2_conf_dir}/*.conf
    sed -i "s@^\(rpc-secret=\).*@\1${aria2_passwd}@" ${aria2_conf}
    sed -i "s@^#\(retry-on-.*=\).*@\1true@" ${aria2_conf}
    sed -i "s@^\(max-connection-per-server=\).*@\132@" ${aria2_conf}
    sed -i '/complete/'d ${aria2_conf}
    sed -i 's/force-save=false/force-save=true/g' ${aria2_conf}
    sed -i "s/max-concurrent-downloads=5/max-concurrent-downloads=8/g" ${aria2_conf}
    echo "on-download-complete=/datasets/sh.sh" >> ${aria2_conf}
    echo "bt-external-ip=$(nslookup freenat.bid | grep -E "Address" | grep -oE "[[:digit:]]+.[^.]+.[^.]+.[^.]+." | grep -vE "^127")" >> ${aria2_conf}
    touch aria2.session
    chmod +x *.sh
    echo -e "${Info} Aria2 完美配置下载完成！"
}
Service_aria2() {
    wget -N -t2 -T3 "https://raw.githubusercontent.com/P3TERX/aria2.sh/master/service/aria2_debian" -O /etc/init.d/aria2 ||
        wget -N -t2 -T3 "https://cdn.jsdelivr.net/gh/P3TERX/aria2.sh@master/service/aria2_debian" -O /etc/init.d/aria2 ||
        wget -N -t2 -T3 "https://gh-raw.p3terx.com/P3TERX/aria2.sh/master/service/aria2_debian" -O /etc/init.d/aria2
    [[ ! -s /etc/init.d/aria2 ]] && {
        echo -e "${Error} Aria2服务 管理脚本下载失败 !"
        exit 1
    }
    chmod +x /etc/init.d/aria2
    update-rc.d -f aria2 defaults
    echo -e "${Info} Aria2服务 管理脚本下载完成 !"
}

Install_aria2() {
    [[ -e ${aria2c} ]] && echo -e "${Error} Aria2 已安装，请检查 !" && exit 1
    echo -e "${Info} 开始下载/安装 主程序..."
    check_new_ver
    Download_aria2
    echo -e "${Info} 开始下载/安装 Aria2 完美配置..."
    Download_aria2_conf
    echo -e "${Info} 开始下载/安装 服务脚本(init)..."
    Service_aria2
    Read_config
    aria2_RPC_port=${aria2_port}
    echo -e "${Info} 开始设置 iptables 防火墙..."
    Set_iptables
    echo -e "${Info} 开始添加 iptables 防火墙规则..."
    Add_iptables
    echo -e "${Info} 开始保存 iptables 防火墙规则..."
    Save_iptables
    echo -e "${Info} 开始创建 下载目录..."
    mkdir -p ${download_path}
    echo -e "${Info} 所有步骤 安装完毕，开始启动..."
    /etc/init.d/aria2 start
}
Read_config() {
    status_type=$1
    if [[ ! -e ${aria2_conf} ]]; then
        if [[ ${status_type} != "un" ]]; then
            echo -e "${Error} Aria2 配置文件不存在 !" && exit 1
        fi
    else
        conf_text=$(cat ${aria2_conf} | grep -v '#')
        aria2_dir=$(echo -e "${conf_text}" | grep "^dir=" | awk -F "=" '{print $NF}')
        aria2_passwd=$(echo -e "${conf_text}" | grep "^rpc-secret=" | awk -F "=" '{print $NF}')
        aria2_bt_port=$(echo -e "${conf_text}" | grep "^listen-port=" | awk -F "=" '{print $NF}')
        aria2_dht_port=$(echo -e "${conf_text}" | grep "^dht-listen-port=" | awk -F "=" '{print $NF}')
    fi
}
View_Aria2() {
    Read_config
    IPV4=$(cat /datasets/frp/frpc.ini | grep -E "server_addr" | head -1 | cut -d" " -f3)
    aria2_port=$(cat /datasets/frp/frpc.ini | grep -E "remote_port" | head -1 | cut -d" " -f3)
    echo -e "${LINE}\nAria2 简单配置信息：\n
IPv4 地址\t: ${Green_font_prefix}http://${IPV4}:${aria2_port}/jsonrpc ${Font_color_suffix}
RPC 密钥\t: ${Green_font_prefix}${aria2_passwd}${Font_color_suffix}"
}
crontab_update_start() {
    crontab -l >"/tmp/crontab.bak"
    sed -i "/aria2.sh update-bt-tracker/d" "/tmp/crontab.bak"
    sed -i "/tracker.sh/d" "/tmp/crontab.bak"
    echo -e "\n0 7 * * * /bin/bash <(wget -qO- git.io/tracker.sh) ${aria2_conf} RPC 2>&1 | tee ${aria2_conf_dir}/tracker.log" >>"/tmp/crontab.bak"
    crontab "/tmp/crontab.bak"
    rm -f "/tmp/crontab.bak"
    Update_bt_tracker
    echo && echo -e "${Info} 自动更新 BT-Tracker 开启成功 !"
}
Update_bt_tracker() {
    check_pid
    [[ -z $PID ]] && {
        bash <(wget -qO- git.io/tracker.sh) ${aria2_conf}
    } || {
        bash <(wget -qO- git.io/tracker.sh) ${aria2_conf} RPC
    }
}
Add_iptables() {
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_RPC_port} -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_bt_port} -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${aria2_dht_port} -j ACCEPT
}
Del_iptables() {
    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_port} -j ACCEPT
    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_bt_port} -j ACCEPT
    iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${aria2_dht_port} -j ACCEPT
}
Save_iptables() {
    if [[ ${release} == "centos" ]]; then
        service iptables save
    else
        iptables-save >/etc/iptables.up.rules
    fi
}
Set_iptables() {
    iptables-save >/etc/iptables.up.rules
    echo -e '#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules' >/etc/network/if-pre-up.d/iptables
    chmod +x /etc/network/if-pre-up.d/iptables
}
VIEW_SSR(){
    IPV4=$(cat /datasets/frp/frpc.ini | grep -E "server_addr" | head -1 | cut -d" " -f3)
    echo -e "\nSSR鏈接信息:"
    echo -e "地址\t\t: ${Green_font_prefix}\"${IPV4}\"${Font_color_suffix}"
    echo -e "端口\t\t: ${Green_font_prefix}\"$(cat /datasets/frp/frpc.ini | grep -E "remote_port" | tail -1 | cut -d" " -f3)\"${Font_color_suffix}"
    echo -e "密碼\t\t: ${Green_font_prefix}\"${aria2_passwd}\"${Font_color_suffix}"
    echo -e "混淆\t\t: ${Green_font_prefix}\"${obfs}\"${Font_color_suffix}"
    echo -e "方法\t\t: ${Green_font_prefix}\"${method}\"${Font_color_suffix}"
    echo -e "協議\t\t: ${Green_font_prefix}\"${protocol}\"${Font_color_suffix}\n"
    
}
echo "开始初始化"
APT_INSTALL > /dev/null 2>&1
echo "完成初始化 & 开始安装Aria2"
Install_aria2 > /dev/null 2>&1
INSTALL_SSR > /dev/null 2>&1
echo "完成安装Aria2 & SSR 》 开始准备链接数据"
crontab_update_start > /dev/null 2>&1
echo "开始打印Aria2 & SSR链接数据"
PASSWD_FILE_INSERT
View_Aria2 && VIEW_SSR
echo -ne "${LINE}\n搭建完成！本Cell会持续运行。可直接关闭网页\n如Aria2遇到断线，可回到网站重新运行本Cell\n如需要添加解压密码，可在旁边新建终端，输入命令：pd \"你的密码\"\n${LINE}\n"
