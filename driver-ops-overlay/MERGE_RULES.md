# Merge rules

1. Extend — newer extract can append missing history months.
2. Overlap — same natural key + month → newer ingest wins.
3. replace_all — only when explicitly tagged; never from filenames.
4. Report extends / overwrites / quarantines every run.
