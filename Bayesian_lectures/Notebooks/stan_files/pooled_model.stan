
//STAN binomial pooled model


data {
    int M;
    int ni[M];
    int Ni[M];
}

parameters {
    real<lower = 0, upper = 1> theta;
}

model {
    // prior theta
    theta ~ beta(1,1);
    
    //likelihood nis
    ni ~ binomial(Ni,theta);
}

generated quantities {
    int n_rep[M] = binomial_rng(Ni,theta);
}
