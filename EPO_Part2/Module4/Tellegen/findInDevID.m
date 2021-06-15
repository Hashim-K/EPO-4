function ID=findInDevID(name)
%ID=findInDevID(name)
% returns the ID of the input devise which can be identified with a string
% equal to name
% 
    ainfo=audiodevinfo;
    for i=1:length(ainfo.input)
        if(~isempty(strfind(ainfo.input(i).Name,name)))
            ID=ainfo.input(i).ID;
            return;
        end
    end
    ID=-1;
end