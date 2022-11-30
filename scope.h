#ifndef SCOPE_H
#define SCOPE_H

#include "symbol.h"
#include "hash_table.h"

struct ht_list {
	struct hash_table *ht;
	int level;
	int num_vars;
	struct ht_list *next;
};


// enter scope (create a new hash table on top of stack)
void scope_enter();
// exit scope (pop ht off stack)
void scope_exit();
// return scope of first value
int scope_level();
// return number of vars in scope
int scope_num_vars();

// adds an entry to topmost ht
void scope_bind( const char *name, struct symbol *sym );
// searches top to bottom for name, Null of not found
struct symbol *scope_lookup( const char *name );
// only searches current
struct symbol *scope_lookup_current( const char *name );

#endif