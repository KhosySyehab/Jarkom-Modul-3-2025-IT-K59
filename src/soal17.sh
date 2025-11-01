# If Nginx on workers requires Basic Auth (noldor:silvan), and Pharazon passes Authorization,
# include credentials in ab using HTTP header: -H "Authorization: Basic <base64>"
# base64 of "noldor:silvan":
echo -n "noldor:silvan" | base64
# suppose it returns QmFzZTY0... ; then:
AB_AUTH="Authorization: Basic <BASE64>"

# Run ab with header:
ab -n 100 -c 10 -H "$AB_AUTH" "http://pharazon.k59.com/"

# or using curl for simpler test:
curl -i -u noldor:silvan http://pharazon.k59.com/

# stop nginx on Galadriel
systemctl stop nginx

# then rerun ab; check pharazon logs
tail -n 200 /var/log/nginx/error.log
