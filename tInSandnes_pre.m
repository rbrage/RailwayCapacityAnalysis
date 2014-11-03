function [fire, transition] = tInSandnes_pre(transition)

global global_info;

if isempty(global_info.next_train_time),

    fire = 0; return;

end;

ctime = current_time();
NTIT = global_info.next_train_time(1);

if lt(ctime, NTIT), fire = 0; return; end;

global_info.next_train_time = global_info.next_train_time(2:end);
trainType = global_info.next_train_type(1);
transition.new_color = {char(trainType)};
fire = 1;
