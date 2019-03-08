% coursework 1
% we write fuction label2vec is used to transfer ouput data format.
% load data, input data is xt, ouput data is yv
data = load('emotions_data_66.mat');
xt = transpose(data.x);   
yt = transpose(data.y);
yv = label2vec(yt); 

% 10-fold cross validation function
[M,N] = size(xt);     
indices = crossvalind('kfold',N,10);
for i = 1:10
    test_data = (indices==i);
    train_data = ~test_data; 
    
    %get trainData,trainTarget,testData,testTarget 
    trainData = xt(:,train_data);
    trainTarget = yv(:,train_data);
    testData = xt(:,test_data);
    testTarget = yv(:,test_data);
    
    % create a new training network 
    net = newff(xt,yv,20,{'tansig','purelin'},'trainscg','learngdm');
       
    % set network parameters
    net.trainParam.show = 5;
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0;
    net.trainParam.mu = 0.02;
    net.trainParam.max_fail = 20;
    
    % training part
    [net,tr] = train(net,trainData, trainTarget);
    
    % testing part 
    t = sim(net,testData);
        
    % outputs = net(trainData);
    % errors = gsubtract(trainTarget,outputs);
    % performance = perform(net,trainTarget,outputs); 
    figure,plotconfusion(testTarget,t);
    
end

