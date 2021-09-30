function r = runBRISQUE(imagePath, colBorder, rowBorder)
  files = ls(strcat(imagePath,'/','*.jp2'))

  [fileCount, ~] = size(files);

  scores = [];
  inputs = strings(1,1);
  outIdx = 1;
  for fileIdx = 1:fileCount
    filePath = strcat(imagePath,'/',files(fileIdx,:))
      
      I = imread(filePath);
      [irows, icols] = size(I);
      if( irows > 2* rowBorder )
        I = I(rowBorder:irows-rowBorder, :);
      end
      if( icols > 2*colBorder )
        I = I(:, colBorder:icols-colBorder);
      end
              
      qualityScore = brisquescore(I);
      inputs(outIdx,1) = filePath();
      scores(outIdx,1) = qualityScore;
      outIdx = outIdx+1;
  end
  
  t = table(inputs, scores);
  writetable(t, strcat(imagePath, '/scores.csv'));

