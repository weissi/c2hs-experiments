#ifndef LIB_TO_INTERFACE__H
#define LIB_TO_INTERFACE__H

typedef void *LTIData;

LTIData lti_new_data(int n);

int lti_element_count(LTIData data);

int lti_get_element(LTIData data, int n);

void lti_free_data(LTIData data);

#endif
