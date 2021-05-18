function time = get_time()
            c = clock;
            time =  c(4) *3600 + c(5)*60 + c(6);
        end