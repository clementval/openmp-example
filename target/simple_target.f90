program main
  call vect_mult(100)
end program main

subroutine vect_mult(n)
  integer :: i, n
  real    :: p(n), v1(n), v2(n)
  call init(v1, v2, n)
  !$omp target
  !$omp parallel do
  do i=1,n
    p(i) = v1(i) * v2(i)
  end do
  !$omp end target
  call output(p, n)
end subroutine vect_mult

subroutine init(v1, v2, n)
  integer, intent(in) :: n
  real, intent(inout) :: v1(n), v2(n)
  integer :: i
  
  do i = 1, n
    v1(i) = 1.0
    v2(i) = 2.0 * i
  end do
end subroutine init

subroutine output(p, n)
  real, intent(in)    :: p(n)
  integer, intent(in) :: n
  integer             :: i
  do i = 1, n
    print*,'p(i):',p(i)
  end do
end subroutine output
