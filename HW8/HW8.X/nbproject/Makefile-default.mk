#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../HW8.c ../i2c_master_noint.c ../mpu6050.c ../nu32dip.c ../ssd1306.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1472/HW8.o ${OBJECTDIR}/_ext/1472/i2c_master_noint.o ${OBJECTDIR}/_ext/1472/mpu6050.o ${OBJECTDIR}/_ext/1472/nu32dip.o ${OBJECTDIR}/_ext/1472/ssd1306.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1472/HW8.o.d ${OBJECTDIR}/_ext/1472/i2c_master_noint.o.d ${OBJECTDIR}/_ext/1472/mpu6050.o.d ${OBJECTDIR}/_ext/1472/nu32dip.o.d ${OBJECTDIR}/_ext/1472/ssd1306.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1472/HW8.o ${OBJECTDIR}/_ext/1472/i2c_master_noint.o ${OBJECTDIR}/_ext/1472/mpu6050.o ${OBJECTDIR}/_ext/1472/nu32dip.o ${OBJECTDIR}/_ext/1472/ssd1306.o

# Source Files
SOURCEFILES=../HW8.c ../i2c_master_noint.c ../mpu6050.c ../nu32dip.c ../ssd1306.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

# The following macros may be used in the pre and post step lines
_/_=/
ShExtension=.sh
Device=PIC32MX170F256B
ProjectDir=/home/scg1224/ME433/ME433_AM/HW8/HW8.X
ProjectName=HW8
ConfName=default
ImagePath=dist/default/${IMAGE_TYPE}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
ImageDir=dist/default/${IMAGE_TYPE}
ImageName=HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
	@echo "--------------------------------------"
	@echo "User defined post-build step: [/home/scg1224/ME433/ME433_AM/HW2/nu32utility /dev/ttyUSB0 ${ImagePath}]"
	@/home/scg1224/ME433/ME433_AM/HW2/nu32utility /dev/ttyUSB0 ${ImagePath}
	@echo "--------------------------------------"

MP_PROCESSOR_OPTION=32MX170F256B
MP_LINKER_FILE_OPTION=,--script="../NU32DIPbootloaded.ld"
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1472/HW8.o: ../HW8.c  .generated_files/flags/default/270ff84fb996146c9e3641508c150748407b436c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/HW8.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/HW8.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/HW8.o.d" -o ${OBJECTDIR}/_ext/1472/HW8.o ../HW8.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/i2c_master_noint.o: ../i2c_master_noint.c  .generated_files/flags/default/cbe1e15a61828ca7bd8c6b4de644c50ffbb091b1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/i2c_master_noint.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/i2c_master_noint.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/i2c_master_noint.o.d" -o ${OBJECTDIR}/_ext/1472/i2c_master_noint.o ../i2c_master_noint.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/mpu6050.o: ../mpu6050.c  .generated_files/flags/default/6972c7754c01ae8ed715290c8567bbcd9ff33e00 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/mpu6050.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/mpu6050.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/mpu6050.o.d" -o ${OBJECTDIR}/_ext/1472/mpu6050.o ../mpu6050.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/nu32dip.o: ../nu32dip.c  .generated_files/flags/default/972e67e0ac349bde344c43fcd52699df0fbb8f5f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/nu32dip.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/nu32dip.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/nu32dip.o.d" -o ${OBJECTDIR}/_ext/1472/nu32dip.o ../nu32dip.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/ssd1306.o: ../ssd1306.c  .generated_files/flags/default/16448e41f6e13b1740539c5b9a71278c77fe2ef7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ssd1306.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ssd1306.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/ssd1306.o.d" -o ${OBJECTDIR}/_ext/1472/ssd1306.o ../ssd1306.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/_ext/1472/HW8.o: ../HW8.c  .generated_files/flags/default/f94b2f1711dbe143ca49a2342fd233f5494fed8e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/HW8.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/HW8.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/HW8.o.d" -o ${OBJECTDIR}/_ext/1472/HW8.o ../HW8.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/i2c_master_noint.o: ../i2c_master_noint.c  .generated_files/flags/default/ef99cc9d6bbba850fa41be5e51b3521723b3c5d5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/i2c_master_noint.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/i2c_master_noint.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/i2c_master_noint.o.d" -o ${OBJECTDIR}/_ext/1472/i2c_master_noint.o ../i2c_master_noint.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/mpu6050.o: ../mpu6050.c  .generated_files/flags/default/a5128989afa22c0befdafb35d6ac21b17cb0304a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/mpu6050.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/mpu6050.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/mpu6050.o.d" -o ${OBJECTDIR}/_ext/1472/mpu6050.o ../mpu6050.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/nu32dip.o: ../nu32dip.c  .generated_files/flags/default/c9ba3ca1609368cc165d6fe611e6fb2c645203cb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/nu32dip.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/nu32dip.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/nu32dip.o.d" -o ${OBJECTDIR}/_ext/1472/nu32dip.o ../nu32dip.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1472/ssd1306.o: ../ssd1306.c  .generated_files/flags/default/ab1e8e1373c53fcfdbf40c05a2af4146a58471ce .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/ssd1306.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/ssd1306.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1472/ssd1306.o.d" -o ${OBJECTDIR}/_ext/1472/ssd1306.o ../ssd1306.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../NU32DIPbootloaded.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)      -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/HW8.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../NU32DIPbootloaded.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/HW8.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}/xc32-bin2hex ${DISTDIR}/HW8.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
