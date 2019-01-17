function MotionEstimation( refFrame, curFrame, sz, bsize, searchRadius )

    % pad to ensure the image size is divisible by the block size
    rframe = padarray(refFrame,[bsize-1 bsize-1],0,'post');
    cframe = padarray(curFrame,[bsize-1 bsize-1],0,'post');
    % initialize empty motion vector matrices
    vmotion = zeros(sz);
    hmotion = zeros(sz);
    for i=1:bsize:sz(1)
        for j=1:bsize:sz(2)
            % this is a block of the reference image
            rblock = rframe(i:i+bsize-1,j:j+bsize-1,:);
            cblock = cframe(i:i+bsize-1,j:j+bsize-1,:);
            
            % TO BE ADDED
            % initialization of error and motion vectors

            e_min=sum(sum(sum(abs(rblock-cblock))));
            dvmotion=0;
            dhmotion=0;
            % setting the bounds of the search region
            lbound = min([searchRadius, j-1]);
            rbound = min([searchRadius, sz(2)-j]);
            ubound = min([searchRadius, i-1]);
            dbound = min([searchRadius, sz(1)-i]);
            for vshift=-ubound:dbound
                for hshift=-lbound:rbound
                    % TO BE ADDED
                    % extracting the block from the current frame
                    % calculating and updating the current values for
                    % the error and motion vectors
                    cblock=cframe(i+vshift:i+vshift+bsize-1,j+hshift:j+hshift+bsize-1,:);
                    e=sum(sum(sum(abs(rblock-cblock))));
                    if e<e_min
                        e_min=e;
                        dhmotion=hshift;
                        dvmotion=vshift;
                    end
                end
            end
            % TO BE ADDED
            % updating the motion vectors based on the search result
            hmotion(i,j)=dhmotion;
            vmotion(i,j)=dvmotion;
        end
    end
    % produce a velocity plot of motion vectors (note the flipping of axis)
    quiver(flipud(hmotion),flipud(-vmotion),10)
    xlim([0 sz(2)])
    ylim([0 sz(1)])
end
