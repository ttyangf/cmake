/*=========================================================================

  Program:   CMake - Cross-Platform Makefile Generator
  Module:    $RCSfile$
  Language:  C++
  Date:      $Date$
  Version:   $Revision$

  Copyright (c) 2002 Kitware, Inc., Insight Consortium.  All rights reserved.
  See Copyright.txt or http://www.cmake.org/HTML/Copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even 
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
     PURPOSE.  See the above copyright notices for more information.

=========================================================================*/
#ifndef cmLocalCodeWarriorGenerator_h
#define cmLocalCodeWarriorGenerator_h

#include "cmLocalGenerator.h"

class cmMakeDepend;
class cmTarget;
class cmSourceFile;

// please remove me.... Yuck
#include "cmSourceGroup.h"

/** \class cmLocalCodeWarriorGenerator
 * \brief Write a LocalUnix makefiles.
 *
 * cmLocalCodeWarriorGenerator produces a LocalUnix makefile from its
 * member m_Makefile.
 */
class cmLocalCodeWarriorGenerator : public cmLocalGenerator
{
public:
  ///! Set cache only and recurse to false by default.
  cmLocalCodeWarriorGenerator();

  virtual ~cmLocalCodeWarriorGenerator();
  
  /**
   * Generate the makefile for this directory. fromTheTop indicates if this
   * is being invoked as part of a global Generate or specific to this
   * directory. The difference is that when done from the Top we might skip
   * some steps to save time, such as dependency generation for the
   * makefiles. This is done by a direct invocation from make. 
   */
  virtual void Generate(bool fromTheTop);

  enum BuildType {STATIC_LIBRARY, DLL, EXECUTABLE, WIN32_EXECUTABLE, UTILITY};

  /**
   * Specify the type of the build: static, dll, or executable.
   */
  void SetBuildType(BuildType,const char *name);

  void WriteTargets(std::ostream& fout);
  void WriteGroups(std::ostream& fout);

private:
  void WriteTarget(std::ostream& fout, const char *name, cmTarget const *l);
  void WriteGroup(std::ostream& fout, const char *name, cmTarget const *l);
  void WriteSettingList(std::ostream& fout, const char *name, 
                        cmTarget const *l);
  void WriteFileList(std::ostream& fout, const char *name, cmTarget const *l);
  void WriteLinkOrder(std::ostream& fout, const char *name, cmTarget const *l);
  void AddFileMapping(std::ostream& fout, const char *ftype,
                      const char *ext, const char *comp,
                      const char *edit, bool precomp,
                      bool launch, bool res, bool ignored);

private:
  // lists the names of the output files of the various targets
  std::map<std::string, std::string> m_TargetOutputFiles;
  // lists which target first references another target's output
  std::map<std::string, std::string> m_TargetReferencingList;
};

#endif

