#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

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

    printf("allocated %p\n", (void *)data);

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
    printf("freeing %p\n", (void *)data);
    LTIDataInternal *d = (LTIDataInternal *)data;
    for (int i=0; i<lti_element_count(data); i++) {
        free(d->data[i]);
    }
    free(d->data);
    free(d);
}

char *lti_version_information(const char *banner) {
    char VERSION[] = "LIB TO INTERFACE v0.2";
    const size_t ver_ret_len = sizeof(VERSION) + strlen(banner);
    char *ver_ret = (char *)malloc(ver_ret_len);

    assert(NULL != ver_ret);
    memset(ver_ret, 0, ver_ret_len);
    memcpy(ver_ret,                  banner, strlen(banner));
    memcpy(ver_ret + strlen(banner), VERSION, sizeof(VERSION));

    printf("allocated string %p\n", ver_ret);

    return ver_ret;
}
