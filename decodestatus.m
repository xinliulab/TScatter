function status = decodestatus(codecache, combinetable)
   if rank(combinetable) == rank([combinetable,codecache]) && rank(combinetable) == size(combinetable, 2)
       status = 1;
   else
       status = 0;
   end
end