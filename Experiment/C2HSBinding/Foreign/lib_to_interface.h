#ifndef LIB_TO_INTERFACE__H
#define LIB_TO_INTERFACE__H

typedef void *LTIData;

/**
 * Returns an allocated LTIData, to be freed using lti_free_data()
 */
LTIData lti_new_data(int n);

int lti_element_count(LTIData data);

int lti_get_element(LTIData data, int n);

void lti_free_data(LTIData data);

/**
 * Returns an malloced version information string. To be freed using free()
 */
char *lti_version_information(const char *banner);

#endif
