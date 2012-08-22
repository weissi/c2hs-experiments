#include <assert.h>
#include <stdlib.h>

#include "lib_to_interface.h"

typedef struct {
    int count;
    int **data;
} LTIDataInternal;

LTIData lti_new_data(int n) {
    LTIDataInternal *data = NULL;

    if (n <= 0) {
        data = malloc(sizeof(LTIDataInternal));
        assert(NULL != data);
        data->count = 0;
        data->data = NULL;
    } else {
        data = malloc(sizeof(LTIDataInternal));
        assert(NULL != data);
        data->count = n;
        data->data = (int **)malloc(n * sizeof(int *));
        assert(NULL != data->data);

        for (int i=0; i<n; i++) {
            data->data[i] = (int *)malloc(sizeof(int));
            assert(NULL != data->data[i]);
            *(data->data[i]) = i;
        }
    }

    return data;
}

int lti_element_count(LTIData data) {
    LTIDataInternal *d = (LTIDataInternal *)data;
    return d->count;
}

int lti_get_element(LTIData data, int n) {
    LTIDataInternal *d = (LTIDataInternal *)data;
    if (n >= lti_element_count(data) || n <= 0) {
        return 0;
    }
    return *(d->data[n]);
}

void lti_free_data(LTIData data) {
    LTIDataInternal *d = (LTIDataInternal *)data;
    for (int i=0; i<lti_element_count(data); i++) {
        free(d->data[i]);
    }
    free(d);
}
