# buat dir kerja
mkdir -p ~/ab_tests_k59 && cd ~/ab_tests_k59

# target (ganti kalau pakai IP)
TARGET="http://elros.k59.com/api/airing/"
# atau:
# TARGET="http://10.93.1.21/api/airing/"

# Serangan Awal
ab -n 100 -c 10 -g ab_initial.tsv -e ab_initial.csv "$TARGET" > ab_initial.txt 2>&1

# Serangan Penuh
ab -n 2000 -c 100 -g ab_full.tsv -e ab_full.csv "$TARGET" > ab_full.txt 2>&1

# ringkasan cepat
grep -E "Requests per second|Time per request|Failed requests|Transfer rate" ab_initial.txt || true
grep -E "Requests per second|Time per request|Failed requests|Transfer rate" ab_full.txt || true


mkdir -p /root/ab_logs
touch /var/log/nginx/access.log /var/log/nginx/error.log
tail -F /var/log/nginx/access.log /var/log/nginx/error.log > /root/ab_logs/elros_tail_before.txt &
echo $! > /root/ab_logs/tail_pid.txt
# hentikan nanti: pkill -F /root/ab_logs/tail_pid.txt


upstream laravel_backend {
    server 10.93.1.2:9000 weight=1;
    server 10.93.1.3:9000 weight=1;
    server 10.93.1.4:9000 weight=1;
}
# location proxy_pass as usual
