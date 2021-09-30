# Modelling Contrast Sensitivity for Chromatic Temporal Modulations
* Type: Conference Paper
* Authors: Kong, Xiangzhen; Bueno Pérez, Mijael R.; Vogels, Ingrid M.L.C.; Sekulovski, Dragan; Heynderickx, Ingrid
* Source: Color and Imaging Conference, 26th Color and Imaging Conference Final Program and Proceedings, pp. 324-329(6)
* DOI: https://doi.org/10.2352/ISSN.2169-2629.2018.26.324
* Publisher: Society for Imaging Science and Technology
* Publication date: November 12, 2018
* Repository update: September 30, 2021

# Data description

*** Initially, during the system calibration process of the device, the 2-degree V(λ) function was adopted for the measurements readout. And during the experiment, a target stimulus UVL [u'(2-degree), v' (2-degree), and luminance (2-degree)] was used to compute the required RGB values as input to the system. All the coordinates (i.e., coordinates in the u'v'-chromaticity diagram) were in 2-degrees. However, later on, we realized that it would make more sense to use the 10-degree version. So, we made corrections as follows: since the input to the system could not be changed anymore, we took the RGB values to compute the SPD, and use the SPD to compute 1) the XYZ values (10-degree), and derived the u'(10-degree), v'(10-degree) coordinates 2) the LMS values using 10-degree cone fundamentals.***

There were three observers, and thus three data files were 'Ann_Data.csv', 'Kon_Data.csv', and 'Mij_Data.csv.'

Here are descriptions  of the columns and brief explanations:
* 'Participant'           : participant, 'ann', 'kon', or 'mij'
* 'Base Color'            : the assigned number of base colors, from 1 to 9
* 'Trial'                 : 0 or 1, which indicates the current trial of the method of adjustment started from an invisible flicker (△(u'v')=0.0004) or a very noticeable  flicker (△(u'v')=0.05).
* 'U'                     : base color - u' of the 1976 UCS chromaticity diagram (2-degree)
* 'V'                     : base color - v' of the 1976 UCS chromaticity diagram (2-degree)
* 'Direction'             : modulation direction (0°, 45°, 90°, 135°)
* 'Frequency'             : temporal frequency (2, 4, 8, 10, 15, 20, 25 Hz)
* 'Ratio'                 : individual isoluminance ratio of the two color stimuli of the chromatic flicker (computed with the 2-degree luminance values)
* 'ThresholdUV'           : △(u'v') in 2-degrees
* 'ThresholdLMS'          : △LMS in 2-degrees
* 'U1'                    : color 1 - u'1 of the 1976 UCS chromaticity diagram (2-degree)
* 'V1'                    : color 1 - v'1 of the 1976 UCS chromaticity diagram (2-degree)
* 'L1'                    : color 1 - luminance 1 (2-degree)
* 'U2'                    : color 2-  u'2 of the 1976 UCS chromaticity diagram (2-degree)
* 'V2'                    : color 2 - v'2 of the 1976 UCS chromaticity diagram (2-degree)
* 'L2'                    : color 2 - luminance 2 (2-degree)
* 'R1'                    : color 1 - red channel input for the system
* 'G1'                    : color 1 - green channel input for the system
* 'B1'                    : color 1 - blue channel input for the system
* 'R2'                    : color 2 - red channel input for the system
* 'G2'                    : color 2 - green channel input for the system
* 'B2'                    : color 2 - blue channel input for the system
* 'L1'                    : long-wavelength-sensitive cone response values for color 1 (2-degree)
* 'M1'                    : medium-wavelength-sensitive cone response values for color 1 (2-degree)
* 'S1'                    : short-wavelength-sensitive cone response values for color 1 (2-degree)
* 'L2'                    : long-wavelength-sensitive cone response values for color 2 (2-degree)
* 'M2'                    : medium-wavelength-sensitive cone response values for color 2 (2-degree)
* 'S2'                    : short-wavelength-sensitive cone response values for color 2 (2-degree)
* 'ThresholdLMS_Corrected': corrected (10-degree) threshold value computed using the 10-degree cone fundamentals
* 'U1_Corrected'          : color 1 - u'1 of the 1976 UCS chromaticity diagram (10-degree)
* 'V1_Corrected'          : color 1 - v'1 of the 1976 UCS chromaticity diagram (10-degree)
* 'L1_Corrected'          : color 1 - luminance 1 (10-degree)
* 'U2_Corrected'          : color 2-  u'2 of the 1976 UCS chromaticity diagram (10-degree)
* 'V2_Corrected'          : color 2 - v'2 of the 1976 UCS chromaticity diagram (10-degree)
* 'L2_Corrected'          : color 2 - luminance 2 (10-degree)
* 'R1_Corrected'          : color 1 - red channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'G1_Corrected'          : color 1 - green channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'B1_Corrected'          : color 1 - blue channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'R2_Corrected'          : color 2 - red channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'G2_Corrected'          : color 2 - green channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'B2_Corrected'          : color 2 - blue channel input for the system (the recomputed RGB value input if using 10-degree measurements for system calibration)
* 'L1_Corrected'          : long-wavelength-sensitive cone response values for color 1 (10-degree)
* 'M1_Corrected'          : medium-wavelength-sensitive cone response values for color 1 (10-degree)
* 'S1_Corrected'          : short-wavelength-sensitive cone response values for color 1 (10-degree)
* 'L2_Corrected'          : long-wavelength-sensitive cone response values for color 2 (10-degree)
* 'M2_Corrected'          : medium-wavelength-sensitive cone response values for color 2 (10-degree)
* 'S2_Corrected'          : short-wavelength-sensitive cone response values for color 2 (10-degree)

*** From the descriptions we can see that not all columns of data are useful. For computations, please only use the 'Corrected' values.***


# Update summary:
* Jul. 19, 2021: uploaded the processed data files (including the individual luminance corrections), and additional example files to fit the TCSFs
* Sep. 30, 2021: uploaded the SPDs of the primaries (full red, full blue and full green) of the light source, so the cone responses can be computed using other cone spectral sensitivity functions
