set( PROJECT_NAME DAUnits )
project( ${PROJECT_NAME} CXX )

add_executable_( ${PROJECT_NAME} TESTS
        DEPENDS
            Boost::unit_test_framework
            DA
            OpenSSL::Crypto
)

target_sources( ${PROJECT_NAME}
        PRIVATE
            main.cpp
)

configure_file( ConfigDA.yml ${CMAKE_CURRENT_BINARY_DIR}/ConfigDA.yml )
add_test_( ${PROJECT_NAME} COMMAND_ARGUMENTS ${CMAKE_CURRENT_BINARY_DIR}/ConfigDA.yml )
