PROGRAM jacobi
#ifdef _OPENMP
  use omp_lib
#endif
  implicit none
  
  integer :: i, j, iter
  integer :: t1, t2, clock_rate, clock_max
  integer, parameter :: n = 100, m=100, iter_max = 100000
  real(8) :: a(n,m), anew(n,m)
  real(8) :: error
  real(8) :: tol

#ifdef _OPENMP
  print*,'Running example with OpenMP enabled'
  print*,'Number of threads: ', omp_get_max_threads()
#endif

  call random_number(a)

  call system_clock ( t1, clock_rate, clock_max )

  !$omp parallel
  do iter = 1, iter_max
    error = 0.0
    !$omp do reduction(max:error)
    do j = 1, n - 1
      do i = 1, m - 1
        anew(j,i) = 0.25 * (a(j, i+1) + a(j, i-1) + a(j-1,i) + a(j+1,i))
        error = max(error, abs(anew(j,i) - a(j,i)))
      end do
    end do
    
    !$omp do
    do j = 1, n - 1
      do i = 1, m - 1
        a(j,i) = anew(j,i)
      end do
    end do
  end do
  !$omp end parallel

  call system_clock ( t2, clock_rate, clock_max )
  write ( *, * ) 'Elapsed real time = ', real ( t2 - t1 ) / real (clock_rate)


  print*, error
END PROGRAM jacobi
