% define states
S1 = 0;
S2 = 1;
S3 = 2;
S4 = 3;

A = 1;
current_state = S1;


% switch to new state based on the value state register
switch (current_state) 
    
    case S1,
        
        % value of output 'Z' depends both on state and inputs
        if (A)
            Z = true;
            current_state = S1;
        else
            Z = false;            
            current_state = S2;
        end
        
    case S2,
        
        if (A)
            Z = false;
            current_state = S1;
        else
            Z = true;
            current_state = S2;
        end
        
    case S3,
        
        if (A)
            Z = false;            
            current_state = S2;
        else
            Z = true;            
            current_state = S3;
        end
        
    case S4,
        
        if (A)
            Z = true;
            current_state = S1;
        else
            Z = false;            
            current_state = S3;
        end        
        
    otherwise,
        
        Z = false;
end