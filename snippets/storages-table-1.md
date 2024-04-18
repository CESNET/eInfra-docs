| Server                                     | Directory                  | Backup<br/>class |  Note                |
|--------------------------------------------|----------------------------| -----------------|----------------------|
| storage-du-cesnet.metacentrum.cz           | /storage/du-cesnet/        | 3                | **Recommended backup and archiving site for MetaCentrum users**  |
| storage-brno1-cerit.metacentrum.cz         | /storage/brno1-cerit/      | 2                | Will be decommisioned by winter/spring 2024; data will be moved to /storage/brno12-cerit/         |
| storage-brno2.metacentrum.cz               | /storage/brno2/            | 2                |          |
| storage-brno11-elixir.metacentrum.cz       | /storage/brno11-elixir/    | 2                |  dedicated to ELIXIR-CZ    |
| storage-brno12-cerit.metacentrum.cz        | /storage/brno12-cerit/     | 2                |                                      |
| storage-plzen1.metacentrum.cz              | /storage/plzen1/           | 2                |             |
| storage-plzen4-ntis.metacentrum.cz         | /storage/plzen4-ntis/      | 3                |  dedicated to iti/kky groups  |
| storage-praha2-natur.metacentrum.cz        | /storage/praha2-natur/     | 0                |               |
| storage-praha6-fzu.metacentrum.cz          | /storage/praha6-fzu/       | 0                |               |
| storage-praha5-elixir.metacentrum.cz       | /storage/praha5-elixir/    | 3                |               | 
| storage-budejovice1.metacentrum.cz         | /storage/budejovice1/      | 3                |             |
| storage-liberec3-tul.metacentrum.cz        | /storage/liberec3-tul/     | 0                |             |
| storage-pruhonice1-ibot.metacentrum.cz     | /storage/pruhonice1-ibot/  | 3                |               |
| storage-vestec1-elixir.metacentrum.cz      | /storage/vestec1-elixir/   |    2             |  also /storage/praha1/           |

| Backup class | Description |
|--------------|-------------|
| 0            | No backup.  |
| 2            | Snapshot backups once a day. Stored on the same HW as primary data. Provides protection against unintentional data removal. Does not provide protection against hardware failure. |
| 3            | Snapshot backups plus a backup copy. Copy resides on different hardware. Provides protection against unintentional data removal as well as hardware failure. |


