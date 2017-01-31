# remove quotes from table names so they're case insensitive
s/(INSERT INTO) ["]([^"]*)["]/\1 \2/

# change user table to users, user conflicts with keyword
s/(INSERT INTO user) /\1s /

# convert mysql boolean false '\0' to just '0'
s/'[\]([0])'/'\1'/g

# convert mysql boolean true ^A (0x01) to just '1'
s/'\x01'/'1'/g

