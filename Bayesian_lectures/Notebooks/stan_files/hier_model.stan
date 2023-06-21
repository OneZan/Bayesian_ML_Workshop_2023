//STAN binomial hierarchical model


data {
	int M;
	int Ni [M];
	int ni [M];
}

parameters {
//parameters
	vector<lower = 0, upper = 1>[M] theta;
    
// Hyperparameters
	real<lower = 0> alpha;
	real<lower = 0> beta;
}

transformed parameters {
	real<lower = 0,upper =1> phi;
	real<lower = 1> kappa;

	kappa =alpha+beta; // efective number of samples
	phi = alpha/kappa; // efective prob of heads.
}

model {
//prior Hyperparameters
	kappa ~ pareto(1,1.5);

// prior parameters
	theta ~ beta(alpha,beta);
    
// likelihood
	ni ~ binomial(Ni,theta);
}

generated quantities {
	real<lower = 0, upper = 1>theta_rep = beta_rng(alpha,beta);
    int ni_rep [M] = binomial_rng(Ni,theta);
}
