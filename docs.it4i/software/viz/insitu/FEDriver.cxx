#include "FEDataStructures.h"
#include <mpi.h>
#include <stdio.h>
#include <unistd.h>
#include <iostream>
#include <stdlib.h>

#ifdef USE_CATALYST
#include "FEAdaptor.h"
#endif

int main(int argc, char** argv)
{
  // Check the input arguments
  if (argc < 5) {
	printf("Not all arguments supplied (grid definition, Python script name)\n");
	return 0;
  }

  unsigned int pointsX = abs(std::stoi(argv[1])); 
  unsigned int pointsY = abs(std::stoi(argv[2]));
  unsigned int pointsZ = abs(std::stoi(argv[3]));
  
  // MPI_Init(&argc, &argv);
  MPI_Init(NULL, NULL);
  Grid grid;

  unsigned int numPoints[3] = { pointsX, pointsY, pointsZ };
  double spacing[3] = { 1, 1.1, 1.3 };
  grid.Initialize(numPoints, spacing);
  Attributes attributes;
  attributes.Initialize(&grid);

#ifdef USE_CATALYST
  // The argument nr. 4 is the Python script name
  FEAdaptor::Initialize(argv[4]);
#endif
  unsigned int numberOfTimeSteps = 1000;
  for (unsigned int timeStep = 0; timeStep < numberOfTimeSteps; timeStep++)
  {
    // Use a time step of length 0.1
    double time = timeStep * 0.1;
    attributes.UpdateFields(time);
#ifdef USE_CATALYST
    FEAdaptor::CoProcess(grid, attributes, time, timeStep, timeStep == numberOfTimeSteps - 1);
#endif
    
    // Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

    // Print actual time step and processor name that handles the calculation
    printf("This is processor %s, time step: %0.3f\n", processor_name, time);
    usleep(500000);
  }

#ifdef USE_CATALYST
  FEAdaptor::Finalize();
#endif
  MPI_Finalize();

  return 0;
}
