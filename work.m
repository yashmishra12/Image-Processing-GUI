
j=8100;

random_arr=[3, 5, 8, 15, 30];
mse_21=[0,0,0,0,0];
snr_21=[0,0,0,0,0];
psnr_21=[0,0,0,0,0];

%% READING 8100 IMAGES into Orignal array

orignal=cell(1,j);
for i=1:j
orignal{i}=imread(sprintf('%d.jpg',i));
end

%% STORING the corresponding images' smooth form into smooth cell
for q=1:5
    
    smooth=cell(1,j);
    h_avg=fspecial('average',random_arr(q));
    for i=1:j

    gaussian=imnoise(orignal{i},'gaussian',0.4  );

    smooth{i}=imfilter(gaussian,h_avg);

    end

    %% FINDING THE MEAN SQUARE ERROR
   
    for i=1:j
    avg_result{i}=immse(orignal{i},smooth{i});
    end

    %%

    mse_avg=0;

    for i=1:j

    mse_avg=mse_avg+avg_result{i};
    end

    mse_avg=mse_avg/j;
    %% PSNR and SNR calculation
    hello=cell(1,j);
    nat=cell(1,j);

    for i=1:j
    [hello{i},nat{i}]=psnr(orignal{i},smooth{i});
    end
    %%
    snr_result=0;
    psnr_result=0;

    for i=1:j

    psnr_result=psnr_result+hello{i};
    snr_result=snr_result+ nat{i};

    end
    %%
    psnr_result=psnr_result/j;
    snr_result=snr_result/j;
    
    psnr_21(q)=psnr_result;
    snr_21(q)=snr_result;
    mse_21(q)=mse_avg;
end
%%


