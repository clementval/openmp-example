FC = ftn
FLAGS = 
#FC = gfortran
#FLAGS = -fopenmp

EXEC=simple_target

all: $(EXEC)

clean: 
	rm -f $(EXEC) *.cub *.ptx

simple_target: simple_target.f90
	$(FC) $(FLAGS) -o simple_target simple_target.f90

run:
	srun --ntasks=1 --gres=gpu:1 -p debug ./simple_target

run_with_prof:
	srun --ntasks=1 --gres=gpu:1 -p debug nvprof ./simple_target


