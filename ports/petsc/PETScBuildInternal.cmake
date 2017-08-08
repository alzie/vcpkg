set (PETSC_HAVE_ACCESS YES)
set (PETSC_HAVE_SIGNAL YES)
set (PETSC_HAVE__LSEEK YES)
set (PETSC_HAVE__GETCWD YES)
set (PETSC_HAVE_MEMMOVE YES)
set (PETSC_HAVE_RAND YES)
set (PETSC_HAVE__SLEEP YES)
set (PETSC_HAVE_TIME YES)
set (PETSC_HAVE_GETCWD YES)
set (PETSC_HAVE_LSEEK YES)
set (PETSC_HAVE__VSNPRINTF YES)
set (PETSC_HAVE__ACCESS YES)
set (PETSC_HAVE_STRICMP YES)
set (PETSC_SIGNAL_CAST  )
set (PETSC_HAVE_VA_COPY YES)
set (PETSC_HAVE_CLOCK YES)
set (PETSC_USE_WINDOWS_GRAPHICS YES)
set (PETSC_USE_ISATTY YES)
set (PETSC_USE_SINGLE_LIBRARY 1)
set (PETSC_USE_MICROSOFT_TIME YES)
set (PETSC_USE_INFO YES)
set (PETSC_USE_BACKWARD_LOOP 1)
set (PETSC_USE_MALLOC_COALESCED YES)
set (PETSC_USE_LOG YES)
set (PETSC_USE_CTABLE 1)
set (PETSC_CLANGUAGE_C YES)
set (PETSC_HAVE_FORTRAN YES)
set (PETSC_USING_F90 YES)
set (PETSC_USING_F2003 YES)
set (PETSC_HAVE_CXX YES)
# set (BUILD_SHARED_LIBS YES)
set (PETSC_HAVE_ISNAN YES)
set (PETSC_HAVE_ISNORMAL YES)
set (PETSC_HAVE__ISNAN YES)
set (PETSC_HAVE__FINITE YES)
set (PETSC_HAVE_ISINF YES)
set (PETSC_HAVE_CXX_COMPLEX YES)



if (PETSC_HAVE_FORTRAN)
  enable_language (Fortran)

  include(FortranCInterface)
  if(FortranCInterface_GLOBAL_CASE STREQUAL "UPPER")
    set (PETSC_HAVE_FORTRAN_CAPS YES)
    set (PETSC_BLASLAPACK_CAPS YES)
  endif()
  if(FortranCInterface_GLOBAL_SUFFIX STREQUAL "_")
    set (PETSC_HAVE_FORTRAN_UNDERSCORE YES)
    set (PETSC_BLASLAPACK_UNDERSCORE YES)
  elseif(FortranCInterface_GLOBAL_SUFFIX STREQUAL "__")
    set (FORTRANDOUBLEUNDERSCORE YES)
    set (PETSC_BLASLAPACK_SUFFIX ${FortranCInterface_GLOBAL_SUFFIX})
  endif()
endif ()
if (PETSC_CLANGUAGE_Cxx OR PETSC_HAVE_CXX)
  enable_language (CXX)
endif ()

set(PETSC_PACKAGE_LIBS)
set(PETSC_PACKAGE_INCLUDES)

find_package(HYPRE)
if(HYPRE_FOUND)
  set (PETSC_HAVE_HYPRE YES)
  list(APPEND PETSC_PACKAGE_LIBS ${HYPRE_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${HYPRE_INCLUDE_PATH})
endif()

find_package(MUMPS)
if(MUMPS_FOUND)
  set (PETSC_HAVE_MUMPS YES)
  list(APPEND PETSC_PACKAGE_LIBS ${MUMPS_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${MUMPS_INCLUDE_PATH})
endif()

find_package(SUPERLU_DIST)
if(SUPERLU_DIST_FOUND)
  set (PETSC_HAVE_SUPERLU_DIST YES)
  list(APPEND PETSC_PACKAGE_LIBS ${SUPERLU_DIST_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${SUPERLU_DIST_INCLUDE_PATH})
endif()

find_package(LAPACK)
if(LAPACK_FOUND)
  set (PETSC_HAVE_BLASLAPACK YES)
  list(APPEND PETSC_PACKAGE_LIBS ${BLAS_LIBRARIES} ${LAPACK_LIBRARIES})
endif()

# set (PETSC_HAVE_FBLASLAPACK YES)

find_package(ParMETIS)
if(ParMETIS_FOUND)
  set (PETSC_HAVE_PARMETIS YES)
  list(APPEND PETSC_PACKAGE_LIBS ${PARMETIS_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${PARMETIS_INCLUDE_DIRS})
endif()

find_package(METIS)
if(METIS_FOUND)
  set (PETSC_HAVE_METIS YES)
  list(APPEND PETSC_PACKAGE_LIBS ${METIS_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${METIS_INCLUDE_DIRS})
endif()

find_package(MPI)
if(MPI_FOUND)
  set (PETSC_HAVE_MPI YES)
  set (PETSC_HAVE_MPI_COMM_C2F YES)
  set (PETSC_HAVE_MPI_INIT_THREAD YES)
  set (PETSC_HAVE_MPI_LONG_DOUBLE YES)
  set (PETSC_HAVE_MPI_COMM_F2C YES)
  set (PETSC_HAVE_MPI_FINT YES)
  set (PETSC_HAVE_MPI_COMM_SPAWN YES)
  set (PETSC_HAVE_MPI_TYPE_GET_ENVELOPE YES)
  set (PETSC_HAVE_MPI_ALLTOALLW YES)
  set (PETSC_HAVE_MPI_FINALIZED YES)
  set (PETSC_HAVE_MPI_COMBINER_CONTIGUOUS YES)
  set (PETSC_HAVE_MPI_EXSCAN YES)
  set (PETSC_HAVE_MPI_TYPE_GET_EXTENT YES)
  set (PETSC_HAVE_MPI_COMBINER_DUP YES)
  set (PETSC_HAVE_MPI_WIN_CREATE YES)
  set (PETSC_HAVE_MPI_REPLACE YES)
  set (PETSC_HAVE_MPI_TYPE_DUP YES)
  set (PETSC_HAVE_MPIIO YES)
  set (PETSC_HAVE_MPI_C_DOUBLE_COMPLEX YES)
  set (PETSC_HAVE_MPI_INT64_T YES)
  set (PETSC_HAVE_MPI_IN_PLACE YES)

  list(APPEND PETSC_PACKAGE_LIBS ${MPI_C_LIBRARIES})
  list(APPEND PETSC_PACKAGE_INCLUDES ${MPI_C_INCLUDE_PATH})

  if(PETSC_HAVE_FORTRAN)
    list(APPEND PETSC_PACKAGE_LIBS ${MPI_Fortran_LIBRARIES})
    list(APPEND PETSC_PACKAGE_INCLUDES ${MPI_Fortran_INCLUDE_PATH})
  endif()
  if(PETSC_HAVE_CXX)
    list(APPEND PETSC_PACKAGE_LIBS ${MPI_CXX_LIBRARIES})
    list(APPEND PETSC_PACKAGE_INCLUDES ${MPI_CXX_INCLUDE_PATH})
  endif()
endif()

set(PETSC_CONFIGURE_OPTIONS "CMAKE configure")

set(PETSC_MACHINE_INFO "Unknown")
set(PETSC_COMPILER_INFO "Unknown")
set(PETSC_COMPILER_FLAGS_INFO "Unknown")
set(PETSC_LINKER_INFO "Unknown")

configure_file(${PROJECT_SOURCE_DIR}/cmake/petscconf.h.in ${CMAKE_BINARY_DIR}/include/petscconf.h)
configure_file(${PROJECT_SOURCE_DIR}/cmake/petscconfiginfo.h.in ${CMAKE_BINARY_DIR}/include/petscconfiginfo.h)
configure_file(${PROJECT_SOURCE_DIR}/cmake/petscfix.h.in ${CMAKE_BINARY_DIR}/include/petscfix.h)
configure_file(${PROJECT_SOURCE_DIR}/cmake/petscmachineinfo.h.in ${CMAKE_BINARY_DIR}/include/petscmachineinfo.h)
