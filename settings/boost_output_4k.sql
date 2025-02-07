-- 
-- Boost patch output buffer size from 512 to 4096 bytes.
-- This matches the spine configuration flag: --with-results-buffer=4096
-- 

ALTER TABLE `%DB_NAME%`.`poller_output_boost` CHANGE `output` `output` VARCHAR(4096) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
