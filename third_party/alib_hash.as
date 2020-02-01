//==================================================================================================
// alib_hash.as / �ȈՃn�b�V�����W���[��
// Version 0.04, September 25, 2008
// Copyright (C) ���D�g���G
// mailto:ayaoritomoe@gmail.com
// http://ayaoritomoe.oiran.org/
//--------------------------------------------------------------------------------------------------
// ������FWindows (Windows XP �œ���m�F)
// �J�����FHot Soup Processor 3.1
// �戵��ʁF�t���[�\�t�g
//==================================================================================================

/*

���̃v���O�����̓t���[�\�t�g�ł��B
���ȐӔC�ł����R�ɂ��g�����������B

//--------------------------------------------------------------------------------------------------
// �C���X�g�[��
//--------------------------------------------------------------------------------------------------
���̃t�@�C���� HSP �� common �t�H���_���A�g�p����X�N���v�g������t�H���_�ɃR�s�[���Ă��������B
�܂��A�g�p����X�N���v�g�̕����� #include "alib_hash.as" �ƋL�q���Ă��������B

//--------------------------------------------------------------------------------------------------
// �g����( �n�b�V���z�񖼂� hash �ŁA������^�̏ꍇ )
//--------------------------------------------------------------------------------------------------

#include "alib_hash.as"

// ������(�����̓�s�͕K���K�v�ł�)
#define ctype hash(%1) HashElem( hash, %1 )
HashInitStr hash

// ����E�Q��
hash("key") = "value"
mes hash("key")

// �^�ϊ��t�l�������(�}�N��)
HashSetValue hash, "��", 3.14159265358979
mes hash("��")

// �����q���g�����L�[�E�l�擾�֐�(�}�N��)
HashResetIter hash
while HashGetEach( hash, key, value ) != -1
  mes key + " = " + value
wend

// �z��𒼐ڎg�����L�[�E�l�擾
foreach hash_keys
  if hash_keys(cnt) == "" : continue
  mes hash_keys(cnt) + " = " + hash_values(cnt)
loop

// �L�[�폜����(�}�N��)
HashDelKey hash, "key"

// �L�[�`�F�b�N�֐�(�}�N��)
if HashCheckKey( hash, "key" ) : mes hash("key")

// �l�̌^�ϊ��V���[�g�J�b�g�}�N��(�Q�Ƃ̂݉�)
#define ctype hash_s(%1) str( hash(%1) )
#define ctype hash_i(%1) int( hash(%1) )
#define ctype hash_d(%1) double( hash(%1) )
mes hash_s("��")
mes hash_i("��")
mes hash_d("��")

// �n�b�V���z��̖��߁E�֐����ł̎󂯕�
#module
#deffunc somefunc array hash_info, array hash_keys, array hash_values
HashResetIterF hash_info
while HashGetEachF( hash_info, hash_keys, hash_values, key, value ) != -1
  mes "somefunc: " + key + " = " + value
wend
return
#global
somefunc HashP(hash)

// �n�b�V���z������p�}�N���̃V���[�g�J�b�g
#define hash_p HashP(hash)
somefunc hash_p

// �t�@�C�����o�͖���(�}�N��)
HashToFile   hash, "hash.txt", "="
HashFromFile hash, "hash.txt", "="

//--------------------------------------------------------------------------------------------------
// �g�p��̒���
//--------------------------------------------------------------------------------------------------

�E�g�p����n�b�V���z��̐������A�����������K�v�ł��B
  #define ctype hash1(%1) HashElem( hash1, %1 )
  HashInitStr hash1
  #define ctype hash2(%1) HashElem( hash2, %1 )
  HashInitDouble hash2

�E�n�b�V���z��̎��̂͒ʏ�̔z��Ȃ̂ŁA�قȂ����^�̒l�̍��݂͂ł��܂���B
  ���ꂼ��Ή��������������߂ŏ��������Ă��������B
  ( HashInitStr / HashInitInt / HashInitDouble )

�E��̃n�b�V���z��ɑ΂��āA�O�̒ʏ�̔z��������I�Ɏg���܂��̂ŁA
  ���̕ϐ����Ƃ��Ԃ�Ȃ��悤�ɋC�����Ă��������B
  ( *_info / *_keys / *_values : �n�b�V���z����p / �L�[�ێ��p / �l�ێ��p
    �n�b�V���z�񖼂� hash �̏ꍇ�Ahash_info / hash_keys / hash_values )

�E�L�[�ɋ󕶎��� "" �͎g�p�ł��܂���B�L�[�ɋ󕶎��� "" ���w�肵���ꍇ�́A"NULL" �Ƃ��Ĉ����܂��B

�E�n�b�V���z�񖼂͎��ۂ̓}�N���Ȃ̂ŁA���̂܂ܖ��߂�֐��̈����Ƃ��ēn���܂���B
  ���߁E�֐����ł͎O�̔z��𒼐ڎ󂯂āA�Ăяo�����ł͎O�̔z��𒼐ڎw�肷�邩�A
  �n�b�V���z������p�}�N���œn���K�v������܂��B
  ( somefunc HashP(hash) �� )

�E�L�[�폜���߂͂��Ȃ�d���̂ŁA�L�[�̍폜�𑽗p����ꍇ�͒��ӂ��Ă��������B
  ���l�Ƀn�b�V���z��̊g�����d���̂ŁA�Ȃ�ׂ����������Ɏg�p����L�[�̐��ȏ���m�ۂ��Ă����Ɨǂ��ł��B

//--------------------------------------------------------------------------------------------------
// �o�[�W��������
//--------------------------------------------------------------------------------------------------
Version 0.04, September 25, 2008 : HashDelKey �� hash_info(HASH_INFO_NUM_KEYS) �o�O�C��
                                   �n�b�V���z��ď��������ߒǉ�( HashClear, HashClearF )
                                   ���o�͖��ߒǉ�( Hash*File*, Hash*Note* )
Version 0.03,      June 15, 2008 : �L�[�폜���ߏC��( HashDelKey, HashDelKeyF ) / �C���^�[�t�F�C�X�͕ύX�Ȃ�
Version 0.02,      June  3, 2008 : ���J

*/

//==================================================================================================
#ifndef ALIB_HASH_AS
#define ALIB_HASH_AS

//==================================================================================================
// �� �n�b�V���֐�
//
// �� HashFunc( hash_key, hash_max )
//
//    hash_key: �n�b�V���L�[������
//    hash_max: �n�b�V����
//
//    �Ԃ�l  : �n�b�V���l( 0 �` hash_max-1 )
//
//==================================================================================================
#module
#defcfunc HashFunc str hash_key, int hash_max
  if hash_max < 1 : return 0
  s = hash_key : n = strlen(s) : hash_value = 0
  repeat n : hash_value = hash_value * 137 + peek(s,cnt) : loop
  return abs( hash_value \ hash_max )
#global

//==================================================================================================
// �� �n�b�V���p�萔
//==================================================================================================
#enum global HASH_INFO_DIM_MAX = 0
#enum global HASH_INFO_DIM_EXT
#enum global HASH_INFO_KEY_MAX
#enum global HASH_INFO_VALUE_MAX
#enum global HASH_INFO_NUM_KEYS
#enum global HASH_INFO_ITER
#enum global HASH_INFO_MAX

#define global HASH_DEFAULT_DIM_MAX  257
#define global HASH_DEFAULT_DIM_EXT   64
#define global HASH_DEFAULT_KEY_MAX   16
#define global HASH_DEFAULT_VALUE_MAX 16

//==================================================================================================
// �� �n�b�V��info�z��V���[�g�J�b�g�}�N��
//
// �� HashDimMax( hash_name )
// �� HashDimExt( hash_name )
// �� HashKeyMax( hash_name )
// �� HashValueMax( hash_name )
// �� HashNumKeys( hash_name )
// �� HashIter( hash_name )
//
//    hash_name: �n�b�V���z��
//
//==================================================================================================
#define global ctype HashDimMax(%1) %1_info(HASH_INFO_DIM_MAX)
#define global ctype HashDimExt(%1) %1_info(HASH_INFO_DIM_EXT)
#define global ctype HashKeyMax(%1) %1_info(HASH_INFO_KEY_MAX)
#define global ctype HashValueMax(%1) %1_info(HASH_INFO_VALUE_MAX)
#define global ctype HashNumKeys(%1) %1_info(HASH_INFO_NUM_KEYS)
#define global ctype HashIter(%1) %1_info(HASH_INFO_ITER)

//==================================================================================================
// �� �n�b�V���z������p�}�N��
//==================================================================================================
#define global ctype HashP(%1) %1_info, %1_keys, %1_values

//==================================================================================================
// �� �n�b�V���z�񏉊�������(�}�N��)
//
// �� HashInitStr    hash_name, dim_max, dim_ext, key_max, value_max
// �� HashInitInt    hash_name, dim_max, dim_ext, key_max
// �� HashInitDouble hash_name, dim_max, dim_ext, key_max
//
//    hash_name: �n�b�V���z��
//    dim_max  : �n�b�V���z��T�C�Y( 1�ȏ�, �f�t�H���g�l = 257 )
//    dim_ext  : �n�b�V���z��g����( 1�ȏ�, �f�t�H���g�l =  64 )
//    key_max  : �L�[������T�C�Y  ( 1�ȏ�, �f�t�H���g�l =  16 )
//    value_max: �l������T�C�Y    ( 1�ȏ�, �f�t�H���g�l =  16 )
//
//--------------------------------------------------------------------------------------------------
// �� �n�b�V���z�񏉊�������
//
// �� HashInitS hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max, value_max
// �� HashInitI hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max
// �� HashInitD hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max
//
//==================================================================================================
#module
#deffunc HashInitS array hash_info, array hash_keys, array hash_values, int dim_max, int dim_ext, int key_max, int value_max
  dim hash_info, HASH_INFO_MAX
  hash_info(HASH_INFO_DIM_MAX)   = dim_max   : if dim_max   < 1 : hash_info(HASH_INFO_DIM_MAX)   = 1
  hash_info(HASH_INFO_DIM_EXT)   = dim_ext   : if dim_ext   < 1 : hash_info(HASH_INFO_DIM_EXT)   = 1
  hash_info(HASH_INFO_KEY_MAX)   = key_max   : if key_max   < 1 : hash_info(HASH_INFO_KEY_MAX)   = 1
  hash_info(HASH_INFO_VALUE_MAX) = value_max : if value_max < 1 : hash_info(HASH_INFO_VALUE_MAX) = 1
  hash_info(HASH_INFO_NUM_KEYS)  = 0

  sdim hash_keys  , hash_info(HASH_INFO_KEY_MAX)  , hash_info(HASH_INFO_DIM_MAX)
  sdim hash_values, hash_info(HASH_INFO_VALUE_MAX), hash_info(HASH_INFO_DIM_MAX)
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashInitI array hash_info, array hash_keys, array hash_values, int dim_max, int dim_ext, int key_max
  dim hash_info, HASH_INFO_MAX
  hash_info(HASH_INFO_DIM_MAX)  = dim_max : if dim_max < 1 : hash_info(HASH_INFO_DIM_MAX) = 1
  hash_info(HASH_INFO_DIM_EXT)  = dim_ext : if dim_ext < 1 : hash_info(HASH_INFO_DIM_EXT) = 1
  hash_info(HASH_INFO_KEY_MAX)  = key_max : if key_max < 1 : hash_info(HASH_INFO_KEY_MAX) = 1
  hash_info(HASH_INFO_NUM_KEYS) = 0

  sdim hash_keys  , hash_info(HASH_INFO_KEY_MAX), hash_info(HASH_INFO_DIM_MAX)
   dim hash_values,                               hash_info(HASH_INFO_DIM_MAX)
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashInitD array hash_info, array hash_keys, array hash_values, int dim_max, int dim_ext, int key_max
  dim hash_info, HASH_INFO_MAX
  hash_info(HASH_INFO_DIM_MAX)  = dim_max : if dim_max < 1 : hash_info(HASH_INFO_DIM_MAX) = 1
  hash_info(HASH_INFO_DIM_EXT)  = dim_ext : if dim_ext < 1 : hash_info(HASH_INFO_DIM_EXT) = 1
  hash_info(HASH_INFO_KEY_MAX)  = key_max : if key_max < 1 : hash_info(HASH_INFO_KEY_MAX) = 1
  hash_info(HASH_INFO_NUM_KEYS) = 0

  sdim hash_keys  , hash_info(HASH_INFO_KEY_MAX), hash_info(HASH_INFO_DIM_MAX)
  ddim hash_values,                               hash_info(HASH_INFO_DIM_MAX)
  return
#global

//--------------------------------------------------------------------------------------------------
#define global HashInitStr(%1,%2=HASH_DEFAULT_DIM_MAX,%3=HASH_DEFAULT_DIM_EXT,%4=HASH_DEFAULT_KEY_MAX,%5=HASH_DEFAULT_VALUE_MAX) HashInitS %1_info, %1_keys, %1_values, %2,%3,%4,%5
#define global HashInitInt(%1,%2=HASH_DEFAULT_DIM_MAX,%3=HASH_DEFAULT_DIM_EXT,%4=HASH_DEFAULT_KEY_MAX) HashInitI %1_info, %1_keys, %1_values, %2,%3,%4
#define global HashInitDouble(%1,%2=HASH_DEFAULT_DIM_MAX,%3=HASH_DEFAULT_DIM_EXT,%4=HASH_DEFAULT_KEY_MAX) HashInitD %1_info, %1_keys, %1_values, %2,%3,%4

//==================================================================================================
// �� �n�b�V���z��ď���������(�}�N��)
//
// �� HashClear hash_name
//
//    hash_name: �n�b�V���z��
//
//--------------------------------------------------------------------------------------------------
// �� �n�b�V���z��ď���������
//
// �� HashClearF hash_info, hash_keys, hash_values
//
//==================================================================================================
#module
#deffunc HashClearF array hash_info, array hash_keys, array hash_values
  dim_max   = hash_info(HASH_INFO_DIM_MAX)
  dim_ext   = hash_info(HASH_INFO_DIM_EXT)
  key_max   = hash_info(HASH_INFO_KEY_MAX)
  value_max = hash_info(HASH_INFO_VALUE_MAX)
  switch vartype( hash_values )
  case 2: HashInitS hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max, value_max : swbreak // ������^
  case 3: HashInitD hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max            : swbreak // �����^
  case 4: HashInitI hash_info, hash_keys, hash_values, dim_max, dim_ext, key_max            : swbreak // �����^
  swend
  return
#global

//--------------------------------------------------------------------------------------------------
#define global HashClear(%1) HashClearF %1_info, %1_keys, %1_values

//==================================================================================================
// �� �L�[�ǉ��֐�(�}�N��)
//
// �� HashAddKey( hash_name, key )
//
//    hash_name: �n�b�V���z��
//    key      : �ǉ�����L�[������( �󕶎��� "" ���w�肵���ꍇ�́A"NULL" �Ƃ��Ĉ����܂� )
//
//    �Ԃ�l   : �L�[�ɑΉ�����z��̃C���f�b�N�X( �L�[���ǉ��ł��Ȃ��ꍇ�� -1 )
//
//--------------------------------------------------------------------------------------------------
// �� �L�[�ǉ��֐�
//
// �� HashAddKeyF( hash_info, hash_keys, key )
//
//==================================================================================================
#module
#defcfunc HashAddKeyF array hash_info, array hash_keys, str key
  hash_key = key : if hash_key == "" : hash_key = "NULL"
  hash_max = hash_info(HASH_INFO_DIM_MAX)

  h = HashFunc( hash_key, hash_max ) : full = 1
  repeat hash_max
    if hash_keys(h) == ""       { hash_keys(h) = hash_key : hash_info(HASH_INFO_NUM_KEYS)++ : full = 0 : break }
    if hash_keys(h) == hash_key {                                                             full = 0 : break }
    h = (h+1) \ hash_max
  loop
  if full { return -1 }else{ return h }
#global

//--------------------------------------------------------------------------------------------------
#define global ctype HashAddKey(%1,%2) HashAddKeyF( %1_info, %1_keys, %2 )

//==================================================================================================
// �� �n�b�V���z��g������(�}�N��)
//
// �� HashExt hash_name
//
//    hash_name: �n�b�V���z��
//
//--------------------------------------------------------------------------------------------------
// �� �n�b�V���z��g������
//
// �� HashExtF hash_info, hash_keys, hash_values
//
//==================================================================================================
#module
#deffunc HashExtF array hash_info, array hash_keys, array hash_values
  var_type  = vartype( hash_values )
  dim_max   = hash_info(HASH_INFO_DIM_MAX)
  dim_ext   = hash_info(HASH_INFO_DIM_EXT)
  key_max   = hash_info(HASH_INFO_KEY_MAX)
  value_max = hash_info(HASH_INFO_VALUE_MAX)

  sdim tmp_keys, key_max, dim_max
  switch var_type
  case 2: sdim tmp_values, value_max, dim_max : swbreak // ������^
  case 3: ddim tmp_values,            dim_max : swbreak // �����^
  case 4:  dim tmp_values,            dim_max : swbreak // �����^
  swend
  repeat dim_max : tmp_keys(cnt) = hash_keys(cnt) : tmp_values(cnt) = hash_values(cnt) : loop

  switch var_type
  case 2: HashInitS hash_info, hash_keys, hash_values, dim_max + dim_ext, dim_ext, key_max, value_max : swbreak // ������^
  case 3: HashInitD hash_info, hash_keys, hash_values, dim_max + dim_ext, dim_ext, key_max            : swbreak // �����^
  case 4: HashInitI hash_info, hash_keys, hash_values, dim_max + dim_ext, dim_ext, key_max            : swbreak // �����^
  swend
  repeat dim_max : if tmp_keys(cnt) != "" { hash_values( HashAddKeyF( hash_info, hash_keys, tmp_keys(cnt) ) ) = tmp_values(cnt) } : loop
  tmp_keys = 0 : tmp_values = 0 : return
#global

//--------------------------------------------------------------------------------------------------
#define global HashExt(%1) HashExtF %1_info, %1_keys, %1_values

//==================================================================================================
// �� �n�b�V���z��o�^�p�֐�(�}�N��)
//
//    �n�b�V���z�񖼂� __hash__ �̏ꍇ�A�ȉ��̂悤�ɓo�^���܂��B
//
//    #define ctype __hash__(%1) HashElem( __hash__, %1 )
//
// �� HashElem( hash_name, key )
//
//    hash_name: �n�b�V���z��
//    key      : �L�[������
//
//--------------------------------------------------------------------------------------------------
// �� �n�b�V���z��C���f�b�N�X�֐�
//
//    �L�[�ɑΉ�����C���f�b�N�X��Ԃ��܂��B
//    �z�񂪖��t�ŃL�[���ǉ��ł��Ȃ��ꍇ�́A�����Ŕz�񂪊g������܂��B
//
// �� HashIndexF( hash_info, hash_keys, hash_values, key )
//
//    key   : �ǉ�����L�[������
//
//    �Ԃ�l: �L�[�ɑΉ�����z��̃C���f�b�N�X
//
//==================================================================================================
#module
#defcfunc HashIndexF array hash_info, array hash_keys, array hash_values, str key
  h = HashAddKeyF( hash_info, hash_keys, key )
  if h == -1 { HashExtF hash_info, hash_keys, hash_values : return HashAddKeyF( hash_info, hash_keys, key ) }else{ return h }
#global

//--------------------------------------------------------------------------------------------------
#define global ctype HashElem(%1,%2) %1_values( HashIndexF( %1_info, %1_keys, %1_values, %2 ) )

//==================================================================================================
// �� �L�[�폜����(�}�N��)
//
// �� HashDelKey hash_name, key
//
//    hash_name: �n�b�V���z��
//    key      : �폜����L�[������
//
//--------------------------------------------------------------------------------------------------
// �� �L�[�폜����
//
// �� HashDelKeyF hash_info, hash_keys, hash_values, key
//
//==================================================================================================
#module
#deffunc HashDelKeyF array hash_info, array hash_keys, array hash_values, str key
  h = HashAddKeyF( hash_info, hash_keys, key ) : if h == -1 : return
  hash_keys(h) = "" : hash_info(HASH_INFO_NUM_KEYS) = 0

  dim_max   = hash_info(HASH_INFO_DIM_MAX)
  key_max   = hash_info(HASH_INFO_KEY_MAX)
  value_max = hash_info(HASH_INFO_VALUE_MAX)

  sdim tmp_keys, key_max, dim_max
  switch vartype( hash_values )
  case 2: sdim tmp_values, value_max, dim_max : v = "" : swbreak // ������^
  case 3: ddim tmp_values,            dim_max : v = 0f : swbreak // �����^
  case 4:  dim tmp_values,            dim_max : v = 0  : swbreak // �����^
  swend

  repeat dim_max
    tmp_keys(cnt)   = hash_keys(cnt)   : hash_keys(cnt)   = ""
    tmp_values(cnt) = hash_values(cnt) : hash_values(cnt) = v
  loop
  repeat dim_max : if tmp_keys(cnt) != "" { hash_values( HashAddKeyF( hash_info, hash_keys, tmp_keys(cnt) ) ) = tmp_values(cnt) } : loop
  tmp_keys = 0 : tmp_values = 0 : return
#global

//--------------------------------------------------------------------------------------------------
#define global HashDelKey(%1,%2) HashDelKeyF %1_info, %1_keys, %1_values, %2

//==================================================================================================
// �� �����q���Z�b�g����(�}�N��)
//
// �� HashResetIter hash_name
//
//    hash_name: �n�b�V���z��
//
//--------------------------------------------------------------------------------------------------
// �� �����q���Z�b�g����
//
// �� HashResetIterF hash_info
//
//==================================================================================================
#module
#deffunc HashResetIterF array hash_info
  hash_info(HASH_INFO_ITER) = -1 : return
#global

//--------------------------------------------------------------------------------------------------
#define global HashResetIter(%1) HashResetIterF %1_info

//==================================================================================================
// �� �����q���g�����L�[�E�l�擾�֐�(�}�N��)
//
// �� HashGetEach( hash_name, key, value )
// �� HashGetKey( hash_name, key )
// �� HashGetValue( hash_name, value )
//
//    hash_name: �n�b�V���z��
//    key      : �L�[����������ϐ�
//    value    : �l����������ϐ�
//
//    �Ԃ�l   : ���݂̔����q�̃C���f�b�N�X( �擾����L�[�E�l���Ȃ��Ȃ����ꍇ -1 )
//
//--------------------------------------------------------------------------------------------------
// �� �����q���g�����L�[�E�l�擾�֐�
//
// �� HashGetEachF( hash_info, hash_keys, hash_values, key, value )
// �� HashGetKeyF( hash_info, hash_keys, key )
// �� HashGetValueF( hash_info, hash_keys, hash_values, value )
//
//==================================================================================================
#module
#defcfunc HashGetEachF array hash_info, array hash_keys, array hash_values, var key, var value
*@
  hash_info(HASH_INFO_ITER)++ : if hash_info(HASH_INFO_DIM_MAX)-1 < hash_info(HASH_INFO_ITER) : return -1
  h = hash_info(HASH_INFO_ITER) : if hash_keys(h) != "" { key = hash_keys(h) : value = hash_values(h) : return h }
goto *@b
#global

//--------------------------------------------------------------------------------------------------
#module
#defcfunc HashGetKeyF array hash_info, array hash_keys, var key
*@
  hash_info(HASH_INFO_ITER)++ : if hash_info(HASH_INFO_DIM_MAX)-1 < hash_info(HASH_INFO_ITER) : return -1
  h = hash_info(HASH_INFO_ITER) : if hash_keys(h) != "" { key = hash_keys(h) : return h }
goto *@b
#global

//--------------------------------------------------------------------------------------------------
#module
#defcfunc HashGetValueF array hash_info, array hash_keys, array hash_values, var value
*@
  hash_info(HASH_INFO_ITER)++ : if hash_info(HASH_INFO_DIM_MAX)-1 < hash_info(HASH_INFO_ITER) : return -1
  h = hash_info(HASH_INFO_ITER) : if hash_keys(h) != "" { value = hash_values(h) : return h }
goto *@b
#global

//--------------------------------------------------------------------------------------------------
#define global ctype HashGetEach(%1,%2,%3) HashGetEachF( %1_info, %1_keys, %1_values, %2, %3 )
#define global ctype HashGetKey(%1,%2) HashGetKeyF( %1_info, %1_keys, %2 )
#define global ctype HashGetValue(%1,%2) HashGetValueF( %1_info, %1_keys, %1_values, %2 )

//==================================================================================================
// �� �L�[�`�F�b�N�֐�(�}�N��)
//
//    key �����ɓo�^����Ă���� 1 �A�o�^����Ă��Ȃ���� 0 ��Ԃ��܂��B
//    key �� �󕶎��� "" ���w�肵���ꍇ�A�z��ɋ󂫂������ 1 ��Ԃ��܂��B
//
// �� HashCheckKey( hash_name, key )
//
//    hash_name: �n�b�V���z��
//    key      : �`�F�b�N����L�[������
//
//    �Ԃ�l   : 1 = key �͓o�^����Ă��� / 0 = key �͓o�^����Ă��Ȃ�
//
//--------------------------------------------------------------------------------------------------
// �� �L�[�`�F�b�N�֐�
//
// �� HashCheckKeyF( hash_info, hash_keys, key )
//
//==================================================================================================
#module
#defcfunc HashCheckKeyF array hash_info, array hash_keys, str key
  hash_key = key
  hash_max = hash_info(HASH_INFO_DIM_MAX)
  if hash_key == "" { h = 0 }else{ h = HashFunc( hash_key, hash_max ) }

  v = 0 : repeat hash_max
    if hash_keys(h) == hash_key { v = 1 : break }
    h = (h+1) \ hash_max
  loop : return v
#global

//--------------------------------------------------------------------------------------------------
#define global ctype HashCheckKey(%1,%2) HashCheckKeyF( %1_info, %1_keys, %2 )

//==================================================================================================
// �� �^�ϊ��t�l�������(�}�N��)
//    �����̃}�N���͓����Ń}���`�X�e�[�g�����g�ɂȂ��Ă���̂ŁAif�����Ŏg���ꍇ�͒��ӂ��Ă��������B
//
// �� HashSetValue hash_name, key, value
//
//    hash_name: �n�b�V���z��
//    key      : �L�[������
//    value    : �l
//
//--------------------------------------------------------------------------------------------------
// �� �^�ϊ��t�l�������
//
// �� HashSetValueF hash_info, hash_keys, hash_values, key, value
//
//    key      : �L�[������
//    value    : �l( �ϐ��̂݉� )
//
//==================================================================================================
#module
#deffunc HashSetValueF array hash_info, array hash_keys, array hash_values, str key, var value
  switch vartype( hash_values )
  case 2: hash_values( HashIndexF( hash_info, hash_keys, hash_values, key ) ) = str(    value ) : swbreak // ������^
  case 3: hash_values( HashIndexF( hash_info, hash_keys, hash_values, key ) ) = double( value ) : swbreak // �����^
  case 4: hash_values( HashIndexF( hash_info, hash_keys, hash_values, key ) ) = int(    value ) : swbreak // �����^
  swend
  return
#global

//--------------------------------------------------------------------------------------------------
#define global HashSetValue(%1,%2,%3) HashSetValue_tmp = %3 : HashSetValueF %1_info, %1_keys, %1_values, %2, HashSetValue_tmp

//==================================================================================================
// �� �t�@�C�����o�͖���(�}�N��)
//    ���󔒗ނ́A���̂܂�key��value�ɔ��f�����̂Œ��ӂ��Ă��������B
//    �����s���܂�key��value���������Ƃ͂ł��܂���B
//
// �� HashFromFile hash_name, filename, d (�t�@�C������key��value��ǂݍ��݂܂�)
// �� HashAddFile  hash_name, filename, d (�t�@�C������key��value��ǂݍ��ݒǉ����܂�)
// �� HashToFile   hash_name, filename, d (�t�@�C����key��value���������݂܂�)
//
//    hash_name: �n�b�V���z��
//    filename : �t�@�C����
//    d        : �f���~�^( �ȗ���, �f�t�H���g�l = ":" )
//
//--------------------------------------------------------------------------------------------------
// �� �t�@�C�����o�͖���
//
// �� HashFromFileF hash_info, hash_keys, hash_values, filename, d
// �� HashAddFileF  hash_info, hash_keys, hash_values, filename, d
// �� HashToFileF   hash_info, hash_keys, hash_values, filename, d
//
//==================================================================================================
// �� �m�[�g�p�b�h���o�͖���(�}�N��)
//    ���󔒗ނ́A���̂܂�key��value�ɔ��f�����̂Œ��ӂ��Ă��������B
//    �����s���܂�key��value���������Ƃ͂ł��܂���B
//
// �� HashFromNote hash_name, note, d (�m�[�g�p�b�h����key��value��ǂݍ��݂܂�)
// �� HashAddNote  hash_name, note, d (�m�[�g�p�b�h����key��value��ǂݍ��ݒǉ����܂�)
// �� HashToNote   hash_name, note, d (�m�[�g�p�b�h��key��value���������݂܂�)
//
//    hash_name: �n�b�V���z��
//    note     : �m�[�g�p�b�h�ϐ�
//    d        : �f���~�^( �ȗ���, �f�t�H���g�l = ":" )
//
//--------------------------------------------------------------------------------------------------
// �� �m�[�g�p�b�h���o�͖���
//
// �� HashFromNoteF hash_info, hash_keys, hash_values, note, d
// �� HashAddNoteF  hash_info, hash_keys, hash_values, note, d
// �� HashToNoteF   hash_info, hash_keys, hash_values, note, d
//
//==================================================================================================
#module
#deffunc HashToNoteF array hash_info, array hash_keys, array hash_values, var note, str d
  if d == "" : return
  note = "" : notesel note
  foreach hash_keys
    if hash_keys(cnt) == "" : continue
    noteadd hash_keys(cnt) + d + hash_values(cnt)
  loop
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashAddNoteF array hash_info, array hash_keys, array hash_values, var note, str d
  if d == "" : return
  notesel note : n = notemax
  repeat n
    notesel note : noteget s,cnt : i = instr(s,0,d) : if i < 1 : continue
    key   = strmid( s, 0, i )
    value = strmid( s, i+strlen(d), strlen(s) )
    HashSetValueF hash_info, hash_keys, hash_values, key, value
  loop
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashFromNoteF array hash_info, array hash_keys, array hash_values, var note, str d
  if d == "" : return
  HashClearF   hash_info, hash_keys, hash_values
  HashAddNoteF hash_info, hash_keys, hash_values, note, d
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashToFileF array hash_info, array hash_keys, array hash_values, str filename, str d
  if d == "" : return
  note = "" : HashToNoteF hash_info, hash_keys, hash_values, note, d
  notesel note : notesave filename
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashAddFileF array hash_info, array hash_keys, array hash_values, str filename, str d
  if d == "" : return
  note = "" : notesel note : noteload filename
  HashAddNoteF hash_info, hash_keys, hash_values, note, d
  return
#global

//--------------------------------------------------------------------------------------------------
#module
#deffunc HashFromFileF array hash_info, array hash_keys, array hash_values, str filename, str d
  if d == "" : return
  note = "" : notesel note : noteload filename
  HashFromNoteF hash_info, hash_keys, hash_values, note, d
  return
#global

//--------------------------------------------------------------------------------------------------
#define global HashToNote(%1,%2,%3=":") HashToNoteF %1_info, %1_keys, %1_values, %2, %3
#define global HashAddNote(%1,%2,%3=":") HashAddNoteF %1_info, %1_keys, %1_values, %2, %3
#define global HashFromNote(%1,%2,%3=":") HashFromNoteF %1_info, %1_keys, %1_values, %2, %3

#define global HashToFile(%1,%2,%3=":") HashToFileF %1_info, %1_keys, %1_values, %2, %3
#define global HashAddFile(%1,%2,%3=":") HashAddFileF %1_info, %1_keys, %1_values, %2, %3
#define global HashFromFile(%1,%2,%3=":") HashFromFileF %1_info, %1_keys, %1_values, %2, %3

#endif /* ALIB_HASH_AS */
//==================================================================================================
//==================================================================================================
//==================================================================================================
