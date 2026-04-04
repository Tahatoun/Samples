CREATE TABLE OrgUnitJob
(
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,

    ProcessId BIGINT NOT NULL,
    ProcessRunId BIGINT NOT NULL,

    OrgUnitId NVARCHAR(100) NOT NULL,

    Status NVARCHAR(30) NOT NULL,
    -- PENDING
    -- IN_PROGRESS
    -- READY_TO_PUBLISH
    -- PUBLISHING
    -- SUCCEEDED
    -- FAILED

    RequestId UNIQUEIDENTIFIER NOT NULL,

    -- =========================
    -- WORKER EXECUTION RETRY
    -- =========================
    WorkerRetryCount INT NOT NULL DEFAULT 0,
    MaxWorkerRetry INT NOT NULL DEFAULT 3,

    -- =========================
    -- KAFKA PUBLISH RETRY
    -- =========================
    PublishRetryCount INT NOT NULL DEFAULT 0,
    MaxPublishRetry INT NOT NULL DEFAULT 5,

    KafkaPublishStatus NVARCHAR(20) NULL,
    -- NULL = not started
    -- PROCESSING = currently publishing
    -- SUCCESS = published
    -- FAILED = permanently failed

    KafkaPublishedAt DATETIME2 NULL,

    -- =========================
    -- DISTRIBUTED LOCK (LEASE)
    -- =========================
    LockedBy NVARCHAR(100) NULL,
    LockedAt DATETIME2 NULL,
    LockExpiryAt DATETIME2 NULL,

    NextAttemptAt DATETIME2 NULL,

    -- =========================
    -- OBSERVABILITY / DEBUG
    -- =========================
    ErrorMessage NVARCHAR(MAX) NULL,

    RowVersion ROWVERSION,

    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL
);