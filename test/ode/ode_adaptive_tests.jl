using DifferentialEquations,Plots
prob = twoDimlinearODEExample()
## Solve and plot
println("Solve and Plot")
sol =solve(prob::ODEProblem,[0,1],Δt=1/2^4,save_timeseries=true,alg=:Rosenbrock32,adaptive=true)

tab = constructBogakiShampine3()
sol =solve(prob::ODEProblem,[0,1],Δt=1/2^4,save_timeseries=true,alg=:ExplicitRK,adaptive=true,tableau=tab)
val1 = maximum(abs(sol.u - sol.u_analytic))
TEST_PLOT && plot(sol,plot_analytic=true)
#gui()

tab = constructDormandPrince()
sol2 =solve(prob::ODEProblem,[0,1],Δt=1/2^4,save_timeseries=true,alg=:ExplicitRK,adaptive=true,tableau=tab)
val2 = maximum(abs(sol2.u - sol2.u_analytic))
TEST_PLOT && plot(sol2,plot_analytic=true)
#gui()


tab = constructRKF8(Float64)
sol3 =solve(prob::ODEProblem,[0,1],Δt=1/2^4,save_timeseries=true,alg=:ExplicitRK,adaptive=true,tableau=tab)
val3 = maximum(abs(sol3.u - sol3.u_analytic))
TEST_PLOT && plot(sol3,plot_analytic=true)
#gui()

length(sol.t)>length(sol2.t)>=length(sol3.t) && max(val1,val2,val3)<2e-3
