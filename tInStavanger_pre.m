function [fire, transition] = tInStavanger_pre(transition)

global global_info;

if isempty(global_info.next_train_time_Stavanger),

    fire = 0; return;

end;

ctime = string_HH_MM_SS(current_time());%current_time();
NTIT = global_info.next_train_time_Stavanger();
nttime = string_HH_MM_SS((NTIT(1,1)*60*60)+(NTIT(1,2)*60));

if eq(ctime, nttime),
  global_info.next_train_time_Stavanger = global_info.next_train_time_Stavanger(2:end,:);
  trainType = global_info.next_train_type(2);
  transition.new_color = {char(trainType)};
  fire = 1;
else
  fire = 0;
end;
