host_fqdn=$1
hostname=$2
cert_c="US"   # Country Name (C, 2 letter code)
cert_s="California"          # Certificate State (S)
cert_l="San Diego"       # Certificate Locality (L)
cert_o="USN NIWC PAC"   # Certificate Organization (O)
cert_ou="CTU-2"      # Certificate Organizational Unit (OU)
cert_cn="${host_fqdn}"    # Certificate Common Name (CN)

sudo openssl req \
    -newkey rsa:4096 \
    -nodes \
    -sha256 \
    -keyout domain.key \
    -x509 \
    -days 365 \
    -out domain.crt \
    -addext "subjectAltName = DNS:${host_fqdn},DNS:${hostname},DNS:localhost" \
    -subj "/C=${cert_c}/ST=${cert_s}/L=${cert_l}/O=${cert_o}/OU=${cert_ou}/CN=${cert_cn}"
