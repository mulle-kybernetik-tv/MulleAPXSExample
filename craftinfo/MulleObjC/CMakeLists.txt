cmake_minimum_required( VERSION 3.0)

project( MulleObjC NONE)

file( GLOB BUILDINFO_DIRS
   MulleObjC*
)

foreach( DIR ${BUILDINFO_DIRS} )
   install( DIRECTORY "${DIR}" DESTINATION "share/mulle-craft"
            USE_SOURCE_PERMISSIONS
            PATTERN "*._DS_Store" EXCLUDE
   )
endforeach()
