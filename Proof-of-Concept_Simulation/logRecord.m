% function logRecord(filename, idx_Hex, idx_Chip, idx_sample, idx, pktCnt, crc, hex, MplChip)
function logRecord(filename, test, symbolTest, number, BER)

fid = fopen(fullfile(pwd, filename ), 'a');
if fid == -1
  error('Cannot open log file.');
end
% fprintf(fid, '%s: %d %2d %6d %2d %2d %d %s %s %s\n', datestr(now, 0), idx_Hex, idx_Chip, idx_sample, idx, pktCnt, crc, hex, MplChip(1:32), MplChip(33:64));
fprintf(fid, '%s: %3d %3d %2d %2.2f\n', datestr(now, 0), test, symbolTest, number, BER);


fclose(fid);

end