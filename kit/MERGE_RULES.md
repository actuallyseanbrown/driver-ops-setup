# Merge rules

1. **Extend** — append missing history months from newer extracts.
2. **Overlap** — same natural key + month → newer ingest wins (land time, not SharePoint hash).
3. **Replace all** — only when explicitly tagged `replace_all`.
4. **Report** — log extends, overwrites, quarantines every run.

Natural key: driver_unique_name + month + region + subregion + qualifier + qualifier_2.
