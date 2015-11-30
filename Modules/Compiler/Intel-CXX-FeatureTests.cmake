# References:
#   - https://software.intel.com/en-us/articles/c0x-features-supported-by-intel-c-compiler
#   - https://software.intel.com/en-us/articles/c14-features-supported-by-intel-c-compiler

# these are not implemented in any version at time of writing
#set(_cmake_feature_test_cxx_variable_templates "${Intel15_CXX14}")
#set(_cmake_feature_test_cxx_relaxed_constexpr "${Intel15_CXX14}")

# unknown if this is implemented
#set(_cmake_feature_test_cxx_aggregate_default_initializers "${Intel15_CXX14}")

set(DETECT_CXX11 "((__cplusplus >= 201103L) ||  defined(__INTEL_CXX11_MODE__) || defined(__GXX_EXPERIMENTAL_CXX0X__))")
set(DETECT_CXX14 "((__cplusplus >= 201103L) && !defined(__INTEL_CXX11_MODE__))")

set(Intel16_CXX14 "__ICC >= 1600 && ${DETECT_CXX14}")
set(_cmake_feature_test_cxx_contextual_conversions "${Intel16_CXX14}")
set(_cmake_feature_test_cxx_generic_lambdas "${Intel16_CXX14}")
set(_cmake_feature_test_cxx_digit_separators "${Intel16_CXX14}")
# This test is supposed to work in Intel 14 but the compiler has a bug
# in versions 14 and 15::
# https://software.intel.com/en-us/forums/intel-c-compiler/topic/600514
set(_cmake_feature_test_cxx_generalized_initializers "${Intel16_CXX14}")

set(Intel15_CXX14 "__ICC >= 1500 && ${DETECT_CXX14}")
set(_cmake_feature_test_cxx_decltype_auto "${Intel15_CXX14}")
set(_cmake_feature_test_cxx_lambda_init_captures "${Intel15_CXX14}")
set(_cmake_feature_test_cxx_attribute_deprecated "${Intel15_CXX14}")
set(_cmake_feature_test_cxx_return_type_deduction "${Intel15_CXX14}")

set(Intel15_CXX11 "__ICC >= 1500 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_alignas "${Intel15_CXX11}")
set(_cmake_feature_test_cxx_alignof "${Intel15_CXX11}")
set(_cmake_feature_test_cxx_inheriting_constructors "${Intel15_CXX11}")
set(_cmake_feature_test_cxx_user_literals "${Intel15_CXX11}")
set(_cmake_feature_test_cxx_thread_local "${Intel15_CXX11}")

set(Intel14_CXX11 "${DETECT_CXX11} && (__ICC > 1400 || (__ICC == 1400 && __INTEL_COMPILER_UPDATE >= 2))")
# Documented as 12.0+ but in testing it only works on 14.0.2+
set(_cmake_feature_test_cxx_decltype_incomplete_return_types "${Intel14_CXX11}")

set(Intel14_CXX11 "__ICC >= 1400 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_delegating_constructors "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_constexpr "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_sizeof_member "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_strong_enums "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_reference_qualified_functions "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_raw_string_literals "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_unicode_literals "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_inline_namespaces "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_unrestricted_unions "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_nonstatic_member_init "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_enum_forward_declarations "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_override "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_final "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_noexcept "${Intel14_CXX11}")
set(_cmake_feature_test_cxx_defaulted_move_initializers "${Intel14_CXX11}")

set(Intel13_CXX11 "__ICC >= 1300 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_explicit_conversions "${Intel13_CXX11}")
set(_cmake_feature_test_cxx_range_for "${Intel13_CXX11}")
# Cannot find Intel documentation for N2640: cxx_uniform_initialization
set(_cmake_feature_test_cxx_uniform_initialization "${Intel13_CXX11}")

set(Intel121_CXX11 "__ICC >= 1210 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_variadic_templates "${Intel121_CXX11}")
set(_cmake_feature_test_cxx_alias_templates "${Intel121_CXX11}")
set(_cmake_feature_test_cxx_nullptr "${Intel121_CXX11}")
set(_cmake_feature_test_cxx_trailing_return_types "${Intel121_CXX11}")
set(_cmake_feature_test_cxx_attributes "${Intel121_CXX11}")
set(_cmake_feature_test_cxx_default_function_template_args "${Intel121_CXX11}")

set(Intel12_CXX11 "__ICC >= 1200 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_extended_friend_declarations "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_rvalue_references "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_decltype "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_defaulted_functions "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_deleted_functions "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_local_type_template_args "${Intel12_CXX11}")
set(_cmake_feature_test_cxx_lambdas "${Intel12_CXX11}")

set(_cmake_oldestSupported "__ICC >= 1110 && ${DETECT_CXX11}")
set(_cmake_feature_test_cxx_binary_literals "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_static_assert "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_right_angle_brackets "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_auto_type "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_extern_templates "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_variadic_macros "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_long_long_type "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_func_identifier "${_cmake_oldestSupported}")
set(_cmake_feature_test_cxx_template_template_parameters "${_cmake_oldestSupported}")
