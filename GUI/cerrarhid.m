function cerrarhid(hObject,eventdata)
global popup elec
elec=get(popup,'Value');
assignin('base','elec',elec);
close(gcf)

end