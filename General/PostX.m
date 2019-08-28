function out=PostX(R)
global v
for i=1:length(R)
    R(i).P80=F80(R(i).Streams.Stream.Value,v);
    R(i).ro=sum(R(i).Streams.Stream.Value)/R(i).Streams.Stream.Value(end);
    R(i).ps=sum(R(i).Streams.Stream.Value(1:end-1))/sum(R(i).Streams.Stream.Value)*100;
    R(i).Mass=sum(R(i).Streams.Stream.Value);
    R(i).Water=R(i).Streams.Stream.Value(end);
end
out=R;

end