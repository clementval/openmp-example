PROGRAM jacobi

  integer :: i, j, iter

  integer, parameter :: n = 100, m=100, iter_max = 100000
  real(8) :: a(n,m), anew(n,m)
  real(8) :: error
  real(8) :: tol

  call random_number(a)

  do iter = 1, iter_max
    error = 0.0
    !$omp parallel do reduction(max:error)
    do j = 1, n - 1
      !$omp simd
      do i = 1, m - 1
        anew(j,i) = 0.25 * (a(j, i+1) + a(j, i-1) + a(j-1,i) + a(j+1,i))
        error = max(error, abs(anew(j,i) - a(j,i)))
      end do
    end do
    
    !$omp parallel do
    do j = 1, n - 1
      !$omp simd
      do i = 1, m - 1
        a(j,i) = anew(j,i)
      end do
    end do
  end do

  print*, error
END PROGRAM jacobi
