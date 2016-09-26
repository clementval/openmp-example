FC = gfortran
FLAGS = -fopenmp


all: info icv

clean: 
	rm info

info: info.f90
	$(FC) $(FLAGS) -o info info.f90

icv: icv.f90
	$(FC) $(FLAGS) -o icv icv.f90
