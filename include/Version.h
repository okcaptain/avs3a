#pragma once
#include "Instruction.h"

#ifdef __cplusplus
extern "C" {
#endif

#define VER_MAJOR				1
#define VER_MINOR				0
#define VER_RELEASE				0
#define VER_BUILD				6

#define GENERIC_VERION(Major, Minor, Release, Build)\
void VERSION_AVS3AudioDec_##Major##_##Minor##_##Release##_##Build(){ }

GENERIC_VERION(1, 0, 0, 6)

#ifdef __cplusplus
}
#endif