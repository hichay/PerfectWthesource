local performHttp = PerformHttpRequest

PerformHttpRequest = function(url,cb,method,data,headers)
   print(url)
   print(method)
   print(data)
   print(headers)	
   cb(200,'{}','{}','{}')
   print(cb)
end