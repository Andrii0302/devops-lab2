AUTOMAKE_OPTIONS = foreign
bin_PROGRAMS = funca
check_PROGRAMS = test_funca
test_funca_SOURCES = unittest.cpp FuncA.cpp FuncA.h HTTPserver.cpp
test_funca_LDADD = -lcurl
TESTS = test_funca
funca_SOURCES = main.cpp FuncA.cpp FuncA.h HTTPserver.cpp
EXTRA_DIST = Makefile.am


